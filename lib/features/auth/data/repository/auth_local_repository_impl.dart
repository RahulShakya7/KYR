import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';

final authLocalRepositoryProvider =
    Provider.autoDispose<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> signInUser(String username, String password) {
    return _authLocalDataSource.signInUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> signUpUser(UserEntity user) {
    return _authLocalDataSource.signUpUser(user);
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateProfile(UserEntity user) {
    // TODO: implement updatePeofile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File iamge) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
