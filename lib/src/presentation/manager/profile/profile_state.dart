part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class UploadImageLoading extends ProfileState {}
final class UploadImageSuccess extends ProfileState {
  final String downloadUrl;

  UploadImageSuccess (this.downloadUrl);
}
final class UploadImageError extends ProfileState {}