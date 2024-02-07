import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/core/failure/failure.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';

import '../../domain/repository/news_repository.dart';
import '../data_source/news_remote_data_source.dart';

final newsRemoteRepositoryProvider = Provider<INewsRepository>(
  (ref) => NewsRemoteRepositoryImpl(
    newsRemoteDataSource: ref.read(newsRemoteDataSourceProvider),
  ),
);

class NewsRemoteRepositoryImpl implements INewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRemoteRepositoryImpl({required this.newsRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteNews(String newsid) {
    return newsRemoteDataSource.deleteNews(newsid);
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews() {
    return newsRemoteDataSource.getNews();
  }

  @override
  Future<Either<Failure, NewsEntity>> singleNews(String newsId) {
    return newsRemoteDataSource.singleNews(newsId);
  }
}
