import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/news_entity.dart';
import '../../domain/repository/news_repository.dart';
import '../model/news_hive_model.dart';

final newsLocalDataSourceProvider =
    Provider<NewsLocalDataSource>((ref) => NewsLocalDataSource(
          hiveService: ref.read(hiveServiceProvider),
          newsHiveModel: ref.read(newsHiveModelProvider),
        ));

class NewsLocalDataSource implements INewsRepository {
  final HiveService hiveService;
  final NewsHiveModel newsHiveModel;

  NewsLocalDataSource({
    required this.hiveService,
    required this.newsHiveModel,
  });

  Future<void> clearNews() async {
    try {
      final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
      await box.clear();
      await box.close();
    } catch (e) {
      throw Failure(error: e.toString());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews() async {
    try {
      final hiveNews = await hiveService.getNews();

      // If there is data in Hive, return it
      if (hiveNews.isNotEmpty) {
        final news = newsHiveModel.toEntityList(hiveNews);
        return Right(news);
      }

      // If there is no data in Hive, return an empty list
      return const Right([]);
    } catch (e) {
      // Handle any error that occurs
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNews(String newsid) async {
    try {
      await hiveService.init();
      final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
      await box.delete(newsid);
      await box.close();
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> singleNews(String newsId) async {
    try {
      await hiveService.init();
      final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
      final newsItem =
          box.values.firstWhereOrNull((news) => news.newsid == newsId);
      await box.close();

      if (newsItem != null) {
        final newsEntity = newsHiveModel.toEntity();
        return Right(newsEntity);
      } else {
        return Left(Failure(error: 'News not found'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> addNewsToHive(List<NewsEntity> news) async {
    try {
      final hiveNews = newsHiveModel.toHiveModelList(news);

      await hiveService.clearNews(); // Clear existing news data
      await hiveService.addNews(hiveNews); // Add news to Hive

      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
