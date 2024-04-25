part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoad extends AuthState {}

final class AuthError extends AuthState {
  final String? error;

  AuthError({required this.error});
}

final class AuthSuccess extends AuthState {
  final String? message;

  AuthSuccess({required this.message});
}
