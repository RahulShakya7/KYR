import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:news_review_app/features/news/data/model/news_hive_model.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_preference.dart';
import '../dto/get_all_news_dto.dart';
import '../model/news_api_model.dart';
import 'news_local_data_source.dart';

final newsRemoteDataSourceProvider = Provider(
  (ref) => NewsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    newsApiModel: ref.read(newsApiModelProvider),
    newsLocalDataSource: ref.read(newsLocalDataSourceProvider),
    newsHiveModel: ref.read(newsHiveModelProvider),
  ),
);

class NewsRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final NewsApiModel newsApiModel;
  final NewsLocalDataSource newsLocalDataSource;
  final NewsHiveModel newsHiveModel;

  NewsRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.newsApiModel,
    required this.newsLocalDataSource,
    required this.newsHiveModel,
  });

  Future<Either<Failure, List<NewsEntity>>> getNews() async {
    try {
      var response = await dio.get(ApiEndpoints.getNews);
      if (response.statusCode == 200) {
        GetAllNewsDTO newsAddDTO = GetAllNewsDTO.fromJson(response.data);
        List<NewsEntity> newsList = newsApiModel.toEntityList(newsAddDTO.data);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        // Hive.registerAdapter(NewsHiveModelAdapter());
        // print('Type ID for NewsHiveModel is: ${NewsHiveModelAdapter().typeId}');
        // final box =
        //     await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
        // box.clear();

        // for (var news in newsList) {
        //   final hiveNews = NewsHiveModel(
        //     newsid: news.newsid,
        //     title: news.title,
        //     content: news.content,
        //     date: news.date,
        //     writer: news.writer,
        //   );

        //   box.put(news.newsid, hiveNews);
        // }
        // print("added to hive");

        // box.close();

        // print(newsList);
        return Right(newsList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, NewsEntity>> singleNews(String newsId) async {
    try {
      var response = await dio.get('${ApiEndpoints.singleNews}/$newsId');

      if (response.statusCode == 200) {
        GetAllNewsDTO newsDTO = GetAllNewsDTO.fromJson(response.data);
        List<NewsEntity> newsList = newsApiModel.toEntityList(newsDTO.data);
        if (newsList.isNotEmpty) {
          NewsEntity newsEntity = newsList.first;
          return Right(newsEntity);
        } else {
          return Left(
            Failure(
              error: 'News not found',
              statusCode: response.statusCode.toString(),
            ),
          );
        }
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteNews(String newsid) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteNews + newsid,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
