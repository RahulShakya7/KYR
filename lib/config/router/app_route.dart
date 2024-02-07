import 'package:news_review_app/features/auth/presentation/view/profile_view.dart';
import 'package:news_review_app/features/auth/presentation/view/sign_in.dart';
import 'package:news_review_app/features/auth/presentation/view/sign_up.dart';
import 'package:news_review_app/features/home/presentation/view/dash_board.dart';
import 'package:news_review_app/features/splash/presentation/view/splash_view.dart';

import '../../features/home/presentation/view/app_information.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/signin';
  static const String registerRoute = '/signup';
  static const String appInfo = '/appinfo';
  static const String profile = '/profile';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      homeRoute: (context) => const DashBoardView(),
      loginRoute: (context) => const SignInView(),
      registerRoute: (context) => const SignUpView(),
      appInfo: (context) => const AppInformationView(),
      profile: (context) => const ProfileView(),
    };
  }
}
