import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/news_repository.dart';

final newsUsecaseProvider = Provider<NewsUseCase>(
  (ref) => NewsUseCase(
    newsRepository: ref.watch(newsRepositoryProvider),
  ),
);

class NewsUseCase {
  final INewsRepository newsRepository;

  NewsUseCase({required this.newsRepository});

  Future<Either<Failure, bool>> deleteNews(String newsid) {
    return newsRepository.deleteNews(newsid);
  }

  Future<Either<Failure, List<NewsEntity>>> getNews() {
    return newsRepository.getNews();
  }

  Future<Either<Failure, NewsEntity>> singleNews(String newsId) {
    return newsRepository.singleNews(newsId);
  }
}
