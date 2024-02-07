import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/news_use_case.dart';
import '../state/news_state.dart';

final newsViewModelProvider = StateNotifierProvider<NewsViewModel, NewsState>(
  (ref) => NewsViewModel(
    ref.watch(newsUsecaseProvider),
    newsId: '',
  ),
);

class NewsViewModel extends StateNotifier<NewsState> {
  final NewsUseCase newsUseCase;

  NewsViewModel(this.newsUseCase, {required String newsId})
      : super(NewsState.initial()) {
    getNews();
    singleNews(newsId);
  }

  deleteNews() {}

  getNews() async {
    if (!mounted) {
      // ViewModel is disposed, do not proceed
      return;
    }
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.getNews();
    state = state.copyWith(news: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, news: r, error: null),
    );
  }

  singleNews(String newsId) async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.singleNews(newsId);

    data.fold(
        (l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) => state =
            state.copyWith(isLoading: false, singleNews: r, error: null));
  }
}
