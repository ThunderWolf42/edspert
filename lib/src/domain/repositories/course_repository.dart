import '../../data/models/course_model.dart';

abstract class CourseRepository {
  Future<CourseResponse> getCourseList();
}