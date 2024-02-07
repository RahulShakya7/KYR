import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_review_app/config/router/app_route.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';
import 'package:news_review_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:news_review_app/features/auth/presentation/viewmodel/auth_viewmodel.dart';

import '../../../../unit_test/auth_signin_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late UserEntity userEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      userEntity = const UserEntity(
        username: 'oopsie',
        firstname: 'Rahul',
        lastname: 'Shakya',
        email: 'oopsie@gmail.com',
        password: 'oopsie123',
      );
    },
  );

  //passed test case
  testWidgets('register view testing', (tester) async {
    when(mockAuthUsecase.signUpUser(userEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'oopsie');

    await tester.enterText(find.byType(TextFormField).at(1), 'Rahul');

    await tester.enterText(find.byType(TextFormField).at(2), 'Shakya');

    await tester.enterText(
        find.byType(TextFormField).at(3), 'oopsie@gmail.com');

    await tester.enterText(find.byType(TextFormField).at(4), 'oopsie123');

    //=========================== Find the register button===========================
    final registerButtonFinder = find.descendant(
      of: find.byType(SingleChildScrollView),
      matching: find.widgetWithText(ElevatedButton, 'Sign Up'),
    );

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(201.4, 574.7), // delta to move
    );

    await tester.tap(registerButtonFinder);

    await tester.pump();

    // Check weather the snackbar is displayed or not
    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);

    expect(find.text('Sign In'), findsOneWidget);
  });

  //failed test case
  // testWidgets('register view but invalid', (tester) async {
  //   when(mockAuthUsecase.signUpUser(userEntity))
  //       .thenAnswer((_) async => Left(Failure(error: 'Invalid registration')));

  //   await tester.pumpWidget(
  //     ProviderScope(
  //       overrides: [
  //         authViewModelProvider.overrideWith(
  //           (ref) => AuthViewModel(mockAuthUsecase),
  //         ),
  //       ],
  //       child: MaterialApp(
  //         initialRoute: AppRoute.registerRoute,
  //         routes: AppRoute.getApplicationRoute(),
  //       ),
  //     ),
  //   );

  //   await tester.pumpAndSettle();

  //   await tester.enterText(find.byType(TextFormField).at(0), 'achyut');

  //   await tester.enterText(
  //       find.byType(TextFormField).at(1), 'achyut@gmail.com');

  //   await tester.enterText(find.byType(TextFormField).at(2), 'achyut123');

  //   await tester.enterText(find.byType(TextFormField).at(3), 'achyut123');

  //   //=========================== Find the register button===========================
  //   final registerButtonFinder =
  //       find.widgetWithText(ElevatedButton, 'REGISTER');

  //   await tester.dragUntilVisible(
  //     registerButtonFinder, // what you want to find
  //     find.byType(SingleChildScrollView), // widget you want to scroll
  //     const Offset(201.4, 574.7), // delta to move
  //   );

  //   await tester.tap(registerButtonFinder);

  //   await tester.pump();

  //   // Check weather the snackbar is displayed or not
  //   expect(find.widgetWithText(SnackBar, 'Registered successfully'),
  //       findsOneWidget);
  // });
}
