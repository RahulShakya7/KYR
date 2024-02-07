import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/auth/data/model/user_api_model.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_preference.dart';
import '../dto/get_user_dto.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    userApiModel: ref.read(userApiModelProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final UserApiModel userApiModel;

  AuthRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.userApiModel});

  Future<Either<Failure, bool>> signUpUser(UserEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.signup,
        data: json.encode({
          "username": user.username,
          "firstname": user.firstname,
          "lastname": user.lastname,
          "email": user.email,
          "password": user.password,
        }),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> signInUser(
    String username,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.signin,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        String userId = response.data["userId"].toString();

        await userSharedPrefs.setUserId(userId);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      await userSharedPrefs
          .getUserId()
          .then((value) => value.fold((l) => null, (r) => token = r));

      String? userId;
      var data0 = await userSharedPrefs.getUserId();
      data0.fold(
        (l) => userId = null,
        (r) => userId = r,
      );

      var response = await dio.get(
        ApiEndpoints.getUser + userId!,
        options: Options(
          headers: {
            'Authorization': '$token',
          },
        ),
      );
      if (response.statusCode == 200) {
        GetUserDTO userAddDTO = GetUserDTO.fromJson(response.data);
        UserEntity profile = userAddDTO.data.toEntity();
        // print("profile $profile");
        return Right(profile);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateProfile(UserEntity updatedUser) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      String? userId;
      var data0 = await userSharedPrefs.getUserId();
      data0.fold(
        (l) => userId = null,
        (r) => userId = r,
      );
      // print(updatedUser);

      var response = await dio.put(ApiEndpoints.editUser + userId!,
          data: updatedUser,
          options: Options(
            headers: {
              'Authorization': '$token',
            },
          ));

      if (response.statusCode == 201) {
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
