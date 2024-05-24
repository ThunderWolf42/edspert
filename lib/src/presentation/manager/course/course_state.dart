part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseSuccess extends CourseState {
  final List<CourseData> courseList;

  CourseSuccess({required this.courseList});
}

final class CourseError extends CourseState {
  final String message;

  CourseError({this.message = 'Unexpected Error'});
}
