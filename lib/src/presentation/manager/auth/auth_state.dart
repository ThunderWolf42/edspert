part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

/// IsSignedInWithGoogle
final class IsSignedInWithGoogleLoading extends AuthState {}

final class IsSignedInWithGoogleSuccess extends AuthState {}

final class IsSignedInWithGoogleError extends AuthState {}

/// SignInWithGoogle
final class SignInGoogleLoading extends AuthState {}

final class SignInGoogleError extends AuthState {
  final String message;

  SignInGoogleError(this.message);
}

final class SignInGoogleSuccess extends AuthState {
  final String email;

  SignInGoogleSuccess(this.email);
}
