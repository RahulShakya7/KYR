import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/features/news/presentation/view/single_news_view.dart';
import 'package:news_review_app/features/news/presentation/viewmodel/news_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';

class NewsDraftView extends ConsumerStatefulWidget {
  const NewsDraftView({super.key});

  @override
  ConsumerState<NewsDraftView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsDraftView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Text(
                  'Latest News',
                  style: TextStyle(
                    fontSize: screenHeight > 900 ? 45 : 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          _buildNewsContent(),
        ],
      ),
    );
  }

  Widget _buildNewsContent() {
    var newsState = ref.watch(newsViewModelProvider);
    var reversedNews = newsState.news.reversed.toList();

    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final PageController pageController = PageController();
    return SizedBox(
      height: screenHeight > 900 ? 500 : 310,
      child: PageView.builder(
        itemCount: reversedNews.length,
        itemBuilder: (context, index) {
          final article = reversedNews[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleNewsView(newsId: article.newsid),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight > 900
                          ? (screenHeight * 0.35)
                          : (screenHeight * 0.28),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            '${ApiEndpoints.newsImageUrl}/${article.nimage}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ClipRect(
                          child: Container(
                            height: 8, // Adjust the height of the clipped area
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Change this to the desired background color
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight > 900 ? 24 : 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: screenHeight > 900 ? 24 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: AppColorConstant.primaryColor,
                        iconSize: 30,
                        onPressed: () {
                          pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                      ),
                    ),

                    // Right Arrow
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        color: AppColorConstant.primaryColor,
                        iconSize: 30,
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
