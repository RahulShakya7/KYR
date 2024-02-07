import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';
import 'package:news_review_app/features/news/domain/use_case/news_use_case.dart';
import 'package:news_review_app/features/news/presentation/viewmodel/news_view_model.dart';

import 'news_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NewsUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late NewsUseCase mockNewsUsecase;
  late ProviderContainer container;

  setUpAll(() {
    mockNewsUsecase = MockNewsUseCase();
    container = ProviderContainer(overrides: [
      newsViewModelProvider
          .overrideWith((ref) => NewsViewModel(mockNewsUsecase, newsId: '')),
    ]);
  });

  test('test to get news from api', () async {
    const news = [
      NewsEntity(
        newsid: '1',
        title: 'test',
        nimage: '1',
        content: 'test test',
        date: 'test',
        writer: 'test',
      )
    ];
    when(mockNewsUsecase.getNews())
        .thenAnswer((_) => Future.value(const Right(news)));

    await container.read(newsViewModelProvider.notifier).getNews();

    final newsState = container.read(newsViewModelProvider);

    expect(newsState.error, isNull);
    expect(newsState.news, equals(news));
  });
}
