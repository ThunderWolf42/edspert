import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/banner_model.dart';

class BannerDataSource {
  Future<List<BannerData>?> getBannerList() async {
    try {
      final bannerPath = '${ApiContants.apiUrl}${ApiContants.bannerPath}';
      final queryParameters = {'limit': 5};
      final response = await Dio().get(
        bannerPath,
        queryParameters: queryParameters,
        options: Options(headers: ApiContants.headers),
      );

      final data = BannerResponse.fromJson(response.data);
      
      return data.data;
    } catch (e, stackTrace) {
      log('Error at getBannerList: ${e.toString()}', stackTrace: stackTrace);
      return null;
    }
  }
}
