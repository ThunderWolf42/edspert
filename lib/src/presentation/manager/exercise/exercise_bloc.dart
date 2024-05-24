import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/exercise_model.dart';
import '../../../domain/repositories/exercise_repository.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseBloc(this.exerciseRepository) : super(ExerciseInitial()) {
    on<ExerciseEvent>((event, emit) async {
      if (event is GetExerciseEvent) {
        emit(ExerciseLoading());
        final result = await exerciseRepository.getExerciseData(event.courseId);
        emit(ExerciseSuccess(exerciseList: result.data ?? []));
      }
    });
  }
}
