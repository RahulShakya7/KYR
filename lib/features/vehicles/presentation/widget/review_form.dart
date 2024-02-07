import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/features/vehicles/presentation/viewmodel/review_view_model.dart';

class ReviewForm extends ConsumerStatefulWidget {
  final String vehicleId;

  const ReviewForm({super.key, required this.vehicleId});

  @override
  ReviewFormState createState() => ReviewFormState();
}

class ReviewFormState extends ConsumerState<ReviewForm> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      // backgroundColor: AppColorConstant.secondaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 120),
              TextField(
                textAlign: TextAlign.start,
                controller: _reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Your Review',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColorConstant.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Your Rating:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 70.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColorConstant.accentColor,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: () {
                      // Here, you can implement the logic to submit the review
                      String comment = _reviewController.text;
                      // You can use the _rating and reviewText variables to send the review to your backend or store it locally.
                      // For simplicity, we are just printing the review here.
                      // print('Rating: $_rating');
                      // print('Review: $comment');
                      // Clear the review text field after submitting
                      _reviewController.clear();

                      // Call the ViewModel's method to submit the review
                      ref
                          .read(reviewViewModelProvider(widget.vehicleId)
                              .notifier)
                          .addReview(
                            context,
                            widget.vehicleId,
                            _rating,
                            comment,
                          );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorConstant.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Submit Review',
                      style: TextStyle(color: AppColorConstant.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
