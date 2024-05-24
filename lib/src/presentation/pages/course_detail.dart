import 'package:flutter/material.dart';

import '../../data/models/course_model.dart';

class CourseDetail extends StatelessWidget {
  final CourseData course;

  const CourseDetail({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(course.courseName ?? 'No Course Name'),
          Text('${course.jumlahDone}/${course.jumlahMateri}'),
        ],
      ),
    );
  }
}
