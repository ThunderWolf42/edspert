part of 'exercise_bloc.dart';

@immutable
sealed class ExerciseState {}

final class ExerciseInitial extends ExerciseState {}

final class ExerciseLoading extends ExerciseState {}

final class ExerciseSuccess extends ExerciseState {
  final List<ExerciseData> exerciseList;

  ExerciseSuccess({required this.exerciseList});
}

final class ExerciseError extends ExerciseState {
  final String message;

  ExerciseError({this.message = 'Unexpected Error'});
}
