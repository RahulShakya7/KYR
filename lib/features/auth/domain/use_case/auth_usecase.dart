import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> signUpUser(UserEntity user) async {
    return await _authRepository.signUpUser(user);
  }

  Future<Either<Failure, bool>> signInUser(
      String username, String password) async {
    return await _authRepository.signInUser(username, password);
  }

  Future<Either<Failure, UserEntity>> getUser() async {
    return await _authRepository.getUser();
  }

  Future<Either<Failure, bool>> updateProfile(UserEntity updatedUser) async {
    return await _authRepository.updateProfile(updatedUser);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File image) async {
    return await _authRepository.uploadProfilePicture(image);
  }
}
