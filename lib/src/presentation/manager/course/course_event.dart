part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCourseEvent extends CourseEvent {}

class SaveCourseEvent extends CourseEvent {
  final CourseData course;

  SaveCourseEvent(this.course);
}
