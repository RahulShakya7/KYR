import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_review_app/config/router/app_route.dart';
import 'package:news_review_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:news_review_app/features/auth/presentation/viewmodel/auth_viewmodel.dart';

import 'sign_in_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthuseCase;

  late bool isLogin;

  setUpAll(() async {
    mockAuthuseCase = MockAuthUseCase();

    isLogin = true;
  });

  testWidgets('login view testing', (WidgetTester tester) async {
    when(mockAuthuseCase.signInUser('oopsie', 'oopsie123'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthuseCase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        )));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'oopsie');

    await tester.enterText(find.byType(TextField).at(1), 'oopsie123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Sign In'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Welcome oopsie'), findsOneWidget);
  });
}
