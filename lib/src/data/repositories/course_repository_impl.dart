import 'dart:developer';

import 'package:dio/dio.dart';

import '../../domain/repositories/course_repository.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<CourseResponse> getCourseList() async {
    try {
      const apiUrl = 'https://edspert.widyaedu.com/';
      const urlPath = '${apiUrl}exercise/data_course';
      final queryParams = {'major_name': 'IPA', 'user_email': 'testerngbayu@gmail.com'};
      final headers = {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a3'};

      final response = await Dio().get(
        urlPath,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      final data = CourseResponse.fromJson(response.data);

      return data;
    } catch (e, stackTrace) {
      log('Error at getCourseList: ${e.toString()}', stackTrace: stackTrace);
      return CourseResponse();
    }
  }
}
