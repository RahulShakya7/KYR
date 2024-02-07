import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/core/shared_prefs/user_shared_preference.dart';
import 'package:news_review_app/features/vehicles/data/model/reviews_api_model.dart';
import 'package:news_review_app/features/vehicles/domain/entity/review_entity.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../domain/entity/vehicle_entity.dart';
import '../dto/get_all_reviews_dto.dart';
import '../dto/get_all_vehicles_dto.dart';
import '../model/vehicle_api_model.dart';

final vehicleRemoteDataSourceProvider = Provider(
  (ref) => VehicleRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    vehicleApiModel: ref.read(vehicleApiModelProvider),
    reviewApiModel: ref.read(reviewApiModelProvider),
  ),
);

class VehicleRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final VehicleApiModel vehicleApiModel;
  final ReviewApiModel reviewApiModel;

  VehicleRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.vehicleApiModel,
    required this.reviewApiModel,
  });

  Future<Either<Failure, List<VehicleEntity>>> getVehicles() async {
    try {
      var response = await dio.get(ApiEndpoints.getVehicles);
      if (response.statusCode == 200) {
        GetAllVehicleDTO vehicleAddDTO =
            GetAllVehicleDTO.fromJson(response.data);
        return Right(vehicleApiModel.toEntityList(vehicleAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException {
      return Left(
        Failure(
          error: "Vehicles not found. Connection Error",
        ),
      );
    }
  }

  Future<Either<Failure, VehicleEntity>> singleVehicle(String vehicleId) async {
    try {
      var response = await dio.get('${ApiEndpoints.singleVehicle}/$vehicleId');

      if (response.statusCode == 200) {
        GetAllVehicleDTO vehicleAddDTO =
            GetAllVehicleDTO.fromJson(response.data);
        List<VehicleEntity> vehicleList =
            vehicleApiModel.toEntityList(vehicleAddDTO.data);
        if (vehicleList.isNotEmpty) {
          VehicleEntity vehicleEntity = vehicleList.first;
          return Right(vehicleEntity);
        } else {
          return Left(
            Failure(
              error: 'Vehicle not found',
              statusCode: response.statusCode.toString(),
            ),
          );
        }
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(
    String vehicleId,
  ) async {
    try {
      String? token;

      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      var headers = {
        'Authorization': 'Bearer $token', // Include the token in the headers
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var response = await dio.get(
        '${ApiEndpoints.getVehicles}/$vehicleId/${ApiEndpoints.vehicleReviews}',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        GetAllReviewsDTO reviewAddDTO =
            GetAllReviewsDTO.fromJson(response.data);
        return Right(reviewApiModel.toEntityList(reviewAddDTO.data));
      } else {
        return Left(
          Failure(
            error: 'Vehicles not found',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> addVehicleReview(
      String vehicleid, double rating, String comment) async {
    try {
      String? token;

      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String addReviewEndpoint =
          '${ApiEndpoints.getVehicles}/$vehicleid/${ApiEndpoints.vehicleReviews}';

      var requestBody = {
        "rating": rating,
        "comment": comment,
      };

      var response = await dio.post(
        addReviewEndpoint,
        data: requestBody,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
        // Review added successfully

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
