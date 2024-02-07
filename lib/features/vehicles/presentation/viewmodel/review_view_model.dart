import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/core/common/snackbar/my_snackbar.dart';

import '../../domain/use_case/vehicle_usecase.dart';
import '../state/reviews_state.dart';

final reviewViewModelProvider =
    StateNotifierProviderFamily<ReviewViewModel, ReviewState, String>(
  (ref, vehicleId) => ReviewViewModel(
    ref.watch(vehicleUsecaseProvider),
    vehicleId,
  ),
);

class ReviewViewModel extends StateNotifier<ReviewState> {
  final VehicleUseCase vehicleUseCase;
  final String vehicleId;

  ReviewViewModel(this.vehicleUseCase, this.vehicleId)
      : super(ReviewState.initial()) {
    getReviews(vehicleId);
  }

  getReviews(vehicleId) async {
    state = state.copyWith(isLoading: true);
    var data = await vehicleUseCase.getAllReviews(vehicleId);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, reviews: r, error: null),
    );
  }

  Future<void> addReview(BuildContext context, String vehicleId, double rating,
      String comment) async {
    state = state.copyWith(isLoading: true);
    final result =
        await vehicleUseCase.addVehicleReview(vehicleId, rating, comment);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(message: failure.error, context: context);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // Optionally, you can refresh the reviews list after adding the review
        getReviews(vehicleId);
        showSnackBar(message: "Review Added", context: context);
      },
    );
  }
}


  // Future<void> addReview(vehicleId, rating, comment) async {
  //   state = state.copyWith(isLoading: true);
  //   var data =
  //       await vehicleUseCase.addVehicleReview(vehicleId, rating, comment);
  //   data.fold(
  //     (failure) => state = state.copyWith(
  //       isLoading: false,
  //       error: failure.error,
  //     ),
  //     (success) => state = state.copyWith(
  //       isLoading: false,
  //       error: null,
  //     ),
  //   );
  // }