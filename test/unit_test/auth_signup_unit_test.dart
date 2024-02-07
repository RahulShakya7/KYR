import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_review_app/core/failure/failure.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';
import 'package:news_review_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:news_review_app/features/auth/presentation/viewmodel/auth_viewmodel.dart';

import 'auth_signup_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthusecase;
  late ProviderContainer container;

  setUpAll(() {
    mockAuthusecase = MockAuthUseCase();
    container = ProviderContainer(overrides: [
      authViewModelProvider
          .overrideWith((ref) => AuthViewModel(mockAuthusecase)),
    ]);
  });

  test('Test for initial state ', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, true);
  });

  test('signup test for the user', () async {
    const user = UserEntity(
      username: 'oopsie',
      firstname: 'Rahul',
      lastname: 'Shakya',
      email: 'oopsie@gmail.com',
      password: 'oopsie123',
    );
    when(mockAuthusecase.signUpUser(user))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container.read(authViewModelProvider.notifier).signUpUser(user);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('signup test for the user', () async {
    const user = UserEntity(
      username: 'oopsie',
      firstname: 'Rahul',
      lastname: 'Shakya',
      email: 'oopsie@gmail.com',
      password: 'oopsie123',
    );
    when(mockAuthusecase.signUpUser(user))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(authViewModelProvider.notifier).signUpUser(user);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });
}
