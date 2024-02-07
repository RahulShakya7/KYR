import '../../domain/entity/news_entity.dart';

class NewsState {
  final bool isLoading;
  final List<NewsEntity> news;
  final NewsEntity? singleNews;
  final String? error;

  NewsState({
    required this.isLoading,
    required this.news,
    required this.singleNews,
    this.error,
  });

  factory NewsState.initial() {
    return NewsState(
      isLoading: false,
      news: [],
      singleNews: null,
    );
  }

  NewsState copyWith({
    bool? isLoading,
    List<NewsEntity>? news,
    NewsEntity? singleNews,
    String? error,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      singleNews: singleNews ?? this.singleNews,
      error: error ?? this.error,
    );
  }
}
