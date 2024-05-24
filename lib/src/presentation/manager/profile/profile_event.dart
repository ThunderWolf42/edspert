part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}


class UploadImageEvent extends ProfileEvent{
  final XFile file;
  UploadImageEvent (this.file);
}