import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';
import 'package:news_review_app/features/news/presentation/view/single_news_view.dart';
import 'package:news_review_app/features/news/presentation/viewmodel/news_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';

final newsProvider = Provider<List<NewsEntity>>((ref) {
  final newsState = ref.watch(newsViewModelProvider);
  return newsState.news;
});

class NewsView extends ConsumerStatefulWidget {
  const NewsView({super.key});

  @override
  ConsumerState<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsView> {
  late ShakeDetector shakeDetector;
  @override
  void initState() {
    super.initState();
    shakeDetector = ShakeDetector(
      onShake: _refreshNews,
    );
    shakeDetector.startListening();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  Future<void> _refreshNews() async {
    await ref.read(newsViewModelProvider.notifier).getNews();
  }

  @override
  Widget build(BuildContext context) {
    var newsState = ref.watch(newsViewModelProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double imageHeight;
    if (screenHeight > 900) {
      imageHeight = screenHeight * 0.32;
    } else {
      imageHeight = screenHeight * 0.26;
    }

    // double useHeight;
    // if (screenHeight > 900) {
    //   useHeight = screenHeight * 0.8;
    // } else {
    //   useHeight = screenHeight * 0.7;
    // }

    return RefreshIndicator(
      onRefresh: _refreshNews,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(12),
                child: const Text(
                  'News',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (newsState.isLoading) ...{
                const CircularProgressIndicator(),
              } else if (newsState.error != null) ...{
                Text(newsState.error!),
              } else if (newsState.news.isEmpty) ...{
                const Center(
                  child: Text('No News'),
                ),
              } else ...{
                Expanded(
                  child: ListView.builder(
                    itemCount: newsState.news.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = newsState.news[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SingleNewsView(newsId: article.newsid),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: imageHeight,
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${ApiEndpoints.newsImageUrl}/${article.nimage}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                article.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight > 900 ? 24 : 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                article.content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenHeight > 900 ? 20 : 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: const Divider(
                                color: AppColorConstant
                                    .accentColor, // Set the color of the line
                                thickness: 2, // Set the thickness of the line
                                height: 20,
                                // Set the height of the line
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class ShakeDetector {
  final Function onShake;
  StreamSubscription<AccelerometerEvent>? _subscription;

  ShakeDetector({required this.onShake});

  void startListening() {
    _subscription = accelerometerEvents?.listen((event) {
      final double acceleration = event.y;

      if (acceleration > 18) {
        onShake();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
