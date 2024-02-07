import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_review_app/core/failure/failure.dart';
import 'package:news_review_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:news_review_app/features/auth/presentation/viewmodel/auth_viewmodel.dart';

import 'auth_signin_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthusecase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockAuthusecase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      authViewModelProvider
          .overrideWith((ref) => AuthViewModel(mockAuthusecase)),
    ]);
  });

  test('Test for initial state ', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
  });

  test('login test with student username and password', () async {
    when(mockAuthusecase.signInUser('oopsie', 'oopsie123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .signInUser(context, 'oopsie', 'oopsie123');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('login test with username and password', () async {
    when(mockAuthusecase.signInUser('oopsie', 'oopsie123'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .signInUser(context, 'oopsie', 'oopsie123');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });
}
