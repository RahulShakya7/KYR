import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/features/vehicles/presentation/viewmodel/review_view_model.dart';

import '../../domain/entity/review_entity.dart';

final averageRatingProvider = Provider.family<double, String>((ref, vehicleId) {
  double calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) {
      return 0.0; // Return 0 if there are no reviews to avoid division by zero
    }

    double totalRating = 0.0;
    for (var review in reviews) {
      totalRating += review.rating;
    }

    return (totalRating / reviews.length);
  }

  final reviewState = ref.watch(reviewViewModelProvider(vehicleId));
  final reviews = reviewState.reviews;

  return calculateAverageRating(reviews);
});

final totalReviewCountProvider = Provider.family<int, String>((ref, vehicleId) {
  final reviewState = ref.watch(reviewViewModelProvider(vehicleId));
  final reviews = reviewState.reviews;

  return reviews.length;
});

class VehicleReviewsView extends ConsumerStatefulWidget {
  final String vehicleId;

  const VehicleReviewsView({super.key, required this.vehicleId});

  @override
  ConsumerState<VehicleReviewsView> createState() => _VehicleReviewsViewState();
}

class _VehicleReviewsViewState extends ConsumerState<VehicleReviewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildVehicleContent(),
    );
  }

  Widget _buildVehicleContent() {
    final reviewState = ref.read(reviewViewModelProvider(widget.vehicleId));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // final itemWidth = screenWidth * 0.9; // 90% of screen width
    // final itemHeight = screenHeight * 0.2; // 20% of screen height

    // double tileHeight;
    // if (screenHeight > 900) {
    //   tileHeight = screenHeight * 0.2;
    // } else {
    //   tileHeight = screenHeight * 0.15;
    // }

    // final reviewState = ref.watch(reviewViewModelProvider);

    if (reviewState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (reviewState.error != null) {
      return Scaffold(
        body: Center(child: Text(reviewState.error!)),
      );
    } else if (reviewState.reviews.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No reviews available.')),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: reviewState.reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  final review = reviewState.reviews[index];
                  return Card(
                    // margin: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: screenHeight * 0.14,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // User Icon Section
                          SizedBox(
                            width: screenWidth * 0.15,
                            child: Column(
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    radius: screenHeight > 900 ? 50 : 20,
                                    child: Icon(
                                      Icons.person,
                                      size: screenHeight > 900 ? 70 : 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // List Tile and Rating Bar Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(review.username,
                                      style: TextStyle(
                                        fontSize: screenHeight > 900 ? 24 : 14,
                                      )),
                                  subtitle: Text(
                                    review.comment,
                                    style: TextStyle(
                                        fontSize: screenHeight > 900 ? 24 : 14),
                                  ),
                                  // trailing: const Icon(Icons.favorite_rounded),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: RatingBar.builder(
                                    initialRating: review.rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: screenHeight > 900 ? 55 : 35,
                                    itemPadding: const EdgeInsets.only(
                                        left: 7, right: 7),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: AppColorConstant.accentColor,
                                    ),
                                    onRatingUpdate: (rating) {},
                                    ignoreGestures: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
