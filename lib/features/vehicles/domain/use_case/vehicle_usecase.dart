import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/vehicles/domain/entity/vehicle_entity.dart';

import '../../../../core/failure/failure.dart';
import '../entity/review_entity.dart';
import '../repository/vehicle_repository.dart';

final vehicleUsecaseProvider = Provider<VehicleUseCase>(
  (ref) => VehicleUseCase(
    vehicleRepository: ref.watch(vehicleRepositoryProvider),
  ),
);

class VehicleUseCase {
  final IVehicleRepository vehicleRepository;

  VehicleUseCase({required this.vehicleRepository});

  Future<Either<Failure, List<VehicleEntity>>> getVehicles() {
    return vehicleRepository.getVehicles();
  }

  Future<Either<Failure, VehicleEntity>> singleVehicle(String vehicleId) {
    return vehicleRepository.singleVehicle(vehicleId);
  }

  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(String vehicleId) {
    return vehicleRepository.getAllReviews(vehicleId);
  }

  Future<Either<Failure, bool>> addVehicleReview(
      String vehicleId, double rating, String comment) {
    return vehicleRepository.addVehicleReview(vehicleId, rating, comment);
  }
}
