import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase)
      : super(AuthState(isLoading: false, user: null)) {
    getUserDetails();
  }

  Future<void> signUpUser(UserEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.signUpUser(student);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> signInUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    bool isLogin = false;
    var data = await _authUseCase.signInUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(message: failure.error, context: context);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        getUserDetails();
        Navigator.popAndPushNamed(context, AppRoute.homeRoute);
        isLogin = success;
        showSnackBar(message: "Login Success", context: context);
      },
    );
    return isLogin;
  }

  getUserDetails() async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.getUser();
    // print("getUserDetails()");
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, user: r),
    );
    // print(data);
  }

  updateProfile(BuildContext context, UserEntity updatedUser) async {
    state.copyWith(isLoading: true);
    // print("Updated : $updatedUser");
    var data = await _authUseCase.updateProfile(updatedUser);

    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, error: null);
      showSnackBar(
        message: 'Profile Updated Successfully',
        context: context,
      );
    });
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> signout(BuildContext context) async {
    try {
      // print("Context: $context");
      // context.read(authStateNotifierProvider.notifier).resetState();
      // Remove the token or any other data from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
      prefs.remove("userId");

      state = AuthState.initial();
      // Navigate to the login or home page as per your app's navigation flow
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute, // Replace with your desired route for login page
        (Route<dynamic> route) => false,
      );
      // ignore: use_build_context_synchronously
      showSnackBar(
        message: "Logged Out",
        context: context,
      );
    } catch (error) {
      // print(error);
    }
  }
}
