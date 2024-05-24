import 'package:dio/dio.dart';
import 'package:edspert/src/data/models/profile_model.dart';

class Profile2Repository {
  Future<ProfileResponse> getProfile() async {
    try {
      final headers = {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a3'};
      final response = await Dio().get(
        'https://edspert.widyaedu.com/users?email=juveticsatu@gmail.com',
        options: Options(headers: headers)
      );

      final data = ProfileResponse.fromJson(response.data);
      return data;
    } catch (e) {
      // Handle exception by rethrowing or returning a default value
      throw Exception('Failed to load profile');
    }
  }
}