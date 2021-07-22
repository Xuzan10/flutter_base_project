import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mcn_app/constants/constants.dart';
import 'package:mcn_app/di/module.dart';
import 'package:mcn_app/exceptions/custom_exceptions.dart';
import 'package:mcn_app/utils/error_helper.dart';

class ApiService {
  final Dio _dio = g<Dio>();

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await _dio.get(
        API.baseUrl + url,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> dioPost(String url, dynamic data) async {
    var responseJson;
    try {
      final response = await _dio.post(
        API.baseUrl + url,
        data: data,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      throw FetchDataException(ErrorHelper.extractApiError(e));
    } catch(e){
      print(e);
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    _checkErrors(response.statusCode);

    print(response.data);

    if (response.statusCode == 200)
      return jsonEncode(response.data);
    else
      throw FetchDataException(
          'Error occured while Communication: ${response.statusCode}');
  }

  _checkErrors(int? statusCode) {
    switch (statusCode) {
      case 400:
        throw BadRequestException("Request Not Valid");
      case 401:
        throw Exception("Something went wrong");
      case 403:
        throw UnauthorisedException("Unauthorised Access Detected");
      case 500:
        throw Exception("Something went wrong");
      default:
    }
  }
}
