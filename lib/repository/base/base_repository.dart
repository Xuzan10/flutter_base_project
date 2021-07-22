import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mcn_app/api/api_service.dart';
import 'package:mcn_app/di/module.dart';
import 'package:mcn_app/models/api_response.dart';
import 'package:mcn_app/utils/utility.dart';

class BaseRepository {
  final ApiService _apiService = getIt<ApiService>();

  BaseRepository();

  Future<ApiResponse> getApi(String url) async {
    bool isInternetAvailable = await Utility.checkInternetConnection();
    if (!isInternetAvailable) {
      return ApiResponse.error("No internet Connection");
    }
    try {
      final response = await _apiService.get(url);
      if (jsonDecode(response)['status']) {
        return ApiResponse.completed(jsonDecode(response));
      } else {
        return ApiResponse.error(jsonDecode(response)['message']);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> postApi(String url, Map<String, dynamic> data,
      {bool isForm = false}) async {
    bool isInternetAvailable = await Utility.checkInternetConnection();
    if (!isInternetAvailable) {
      return ApiResponse.error("No internet Connection");
    }
    try {
      final response = await _apiService.dioPost(
          url, isForm ? FormData.fromMap(data) : data);
      if (jsonDecode(response)['status']) {
        return ApiResponse.completed(jsonDecode(response));
      } else {
        return ApiResponse.error(jsonDecode(response)['message']);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
