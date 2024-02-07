import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_local_repository_impl.dart';
import '../../data/repository/auth_remote_repository_impl.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // final internetStatus = ref.watch(connectivityStatusProvider);
  // print(internetStatus);
  return ref.read(authRemoteRepositoryProvider);
  // Check for the internet
  // final internetStatus = ref.watch(connectivityStatusProvider);
  // // print(internetStatus);

  // if (ConnectivityStatus.isConnected == internetStatus) {
  //   // If internet is available then return remote repo
  //   return ref.read(authRemoteRepositoryProvider);
  // } else {
  //   // If internet is not available then return local repo
  //   return ref.read(authLocalRepositoryProvider);
  // }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> signUpUser(UserEntity user);
  Future<Either<Failure, bool>> signInUser(String username, String password);
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, bool>> updateProfile(UserEntity updatedUser);
  Future<Either<Failure, String>> uploadProfilePicture(File image);
}
