import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/vehicles/domain/entity/review_entity.dart';
import 'package:news_review_app/features/vehicles/domain/entity/vehicle_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/vehicle_remote_repo_impl.dart';

final vehicleRepositoryProvider = Provider<IVehicleRepository>((ref) {
  return ref.read(vehicleRemoteRepositoryProvider);
});

abstract class IVehicleRepository {
  Future<Either<Failure, List<VehicleEntity>>> getVehicles();
  Future<Either<Failure, VehicleEntity>> singleVehicle(String vehicleId);
  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(String vehicleId);
  Future<Either<Failure, bool>> addVehicleReview(String vehicleId, double rating, String comment);
}
