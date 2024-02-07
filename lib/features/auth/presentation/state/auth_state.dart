import '../../domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserEntity? user;
  final String? imageName;

  AuthState({
    required this.isLoading,
    this.error,
    required this.user,
    this.imageName,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      user: null,
      imageName: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? error,
    String? imageName,
  }) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user,
        error: error ?? this.error,
        imageName: imageName ?? this.imageName);
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading,user: $user, error: $error)';
}
