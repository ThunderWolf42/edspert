part of 'exercise_bloc.dart';

@immutable
sealed class ExerciseEvent {}

class GetExerciseEvent extends ExerciseEvent {
  final String courseId;

  GetExerciseEvent(this.courseId);
}
