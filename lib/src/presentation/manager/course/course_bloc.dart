import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/course_model.dart';
import '../../../domain/repositories/course_repository.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;
  CourseBloc({required this.courseRepository}) : super(CourseInitial()) {
    on<CourseEvent>((event, emit) async {
      if (event is GetCourseEvent) {
        emit(CourseLoading());
        final result = await courseRepository.getCourseList();
        emit(CourseSuccess(courseList: result.data ?? []));
      }
    });
  }
}
