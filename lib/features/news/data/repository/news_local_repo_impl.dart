import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repository/news_repository.dart';
import '../data_source/news_local_data_source.dart';

final newsLocalRepositoryProvider = Provider<INewsRepository>(
  (ref) => NewsLocalRepositoryImpl(
    newsLocalDataSource: ref.read(newsLocalDataSourceProvider),
  ),
);

class NewsLocalRepositoryImpl implements INewsRepository {
  final NewsLocalDataSource newsLocalDataSource;

  NewsLocalRepositoryImpl({required this.newsLocalDataSource});

  @override
  Future<Either<Failure, bool>> deleteNews(String newsid) {
    return newsLocalDataSource.deleteNews(newsid);
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews() {
    return newsLocalDataSource.getNews();
  }

  @override
  Future<Either<Failure, NewsEntity>> singleNews(String newsId) {
    return newsLocalDataSource.singleNews(newsId);
  }
}
