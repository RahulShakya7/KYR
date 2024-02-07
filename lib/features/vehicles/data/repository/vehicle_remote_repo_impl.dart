import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/core/failure/failure.dart';
import 'package:news_review_app/features/vehicles/domain/entity/review_entity.dart';
import 'package:news_review_app/features/vehicles/domain/entity/vehicle_entity.dart';

import '../../../vehicles/domain/repository/vehicle_repository.dart';
import '../data_source/vehicle_remote_data_source.dart';

final vehicleRemoteRepositoryProvider = Provider<IVehicleRepository>(
  (ref) => VehicleRemoteRepositoryImpl(
    vehicleRemoteDataSource: ref.read(vehicleRemoteDataSourceProvider),
  ),
);

class VehicleRemoteRepositoryImpl implements IVehicleRepository {
  final VehicleRemoteDataSource vehicleRemoteDataSource;

  VehicleRemoteRepositoryImpl({required this.vehicleRemoteDataSource});

  @override
  Future<Either<Failure, List<VehicleEntity>>> getVehicles() {
    return vehicleRemoteDataSource.getVehicles();
  }

  @override
  Future<Either<Failure, VehicleEntity>> singleVehicle(String vehicleId) {
    return vehicleRemoteDataSource.singleVehicle(vehicleId);
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(String vehicleId) {
    return vehicleRemoteDataSource.getAllReviews(vehicleId);
  }

  @override
  Future<Either<Failure, bool>> addVehicleReview(
      String vehicleId, double rating, String comment) {
    return vehicleRemoteDataSource.addVehicleReview(vehicleId, rating, comment);
  }
}
