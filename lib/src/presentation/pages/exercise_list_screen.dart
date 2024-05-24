import 'package:edspert/src/data/repositories/exercise_repository_impl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/exercise/exercise_bloc.dart';

class ExerciseListScreen extends StatelessWidget {
  final String courseId;
  const ExerciseListScreen({super.key, required this.courseId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseBloc(ExerciseRepositoryImpl())
        ..add(
          GetExerciseEvent(courseId),
        ),
      child: Scaffold(
        appBar: AppBar(    
        ),
        body: BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (context, state) {
            if (state is ExerciseSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.exerciseList.length,
                itemBuilder: (context, index) {
                  final exercise = state.exerciseList[index];
                  return Text(exercise.exerciseTitle ?? 'No Title');
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

