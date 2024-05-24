part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class IsSignedInWithGoogleEvent extends AuthEvent {}

final class SignInWithGoogleEvent extends AuthEvent {}
