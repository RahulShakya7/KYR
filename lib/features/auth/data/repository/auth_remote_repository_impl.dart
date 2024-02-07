import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';

final authRemoteRepositoryProvider =
    Provider.autoDispose<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> signInUser(String username, String password) {
    return _authRemoteDataSource.signInUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> signUpUser(UserEntity user) {
    return _authRemoteDataSource.signUpUser(user);
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() {
    return _authRemoteDataSource.getUser();
  }

  @override
  Future<Either<Failure, bool>> updateProfile(UserEntity updatedUser) {
    return _authRemoteDataSource.updateProfile(updatedUser);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File image) {
    return _authRemoteDataSource.uploadProfilePicture(image);
  }
}
