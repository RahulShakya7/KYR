import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';
import 'package:news_review_app/features/news/presentation/viewmodel/news_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/constants/theme_constant.dart';
import '../../../../core/common/provider/internet_connectivity.dart';

class SingleNewsView extends ConsumerStatefulWidget {
  final String newsId;

  const SingleNewsView({super.key, required this.newsId});

  @override
  ConsumerState<SingleNewsView> createState() => _SingleNewsViewState();
}

class _SingleNewsViewState extends ConsumerState<SingleNewsView> {
  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsViewModelProvider);
    final article = _findNewsArticle(newsState.news, widget.newsId);

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color:
                Color.fromARGB(255, 205, 205, 205), // Set button color to grey
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColorConstant.secondaryColor,
            size: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: article != null ? _buildArticleContent(article) : _buildNotFound(),
    );
  }

  NewsEntity? _findNewsArticle(List<NewsEntity> news, String newsId) {
    try {
      return news.firstWhere((article) => article.newsid == newsId);
    } catch (e) {
      return null;
    }
  }

  Widget _buildArticleContent(NewsEntity article) {
    final dateTime = DateTime.parse(article.date);
    final formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    final internetStatus = ref.watch(connectivityStatusProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Date: $formattedDate',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Writer: ${article.writer}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ConnectivityStatus.isConnected == internetStatus
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${ApiEndpoints.newsImageUrl}${article.nimage}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('./assets/images/news.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return const Center(
      child: Text('Article not found'),
    );
  }
}
