import 'dart:io';

import 'package:dio/dio.dart';

class ErrorHelper {
  static String getErrorMessage(error) {
    String errorMessage = "Something went wrong";
    print('error helper === $error');
    if (error is DioError) {
      errorMessage = extractApiError(error);
    } else if (error is String) {
      return error;
    }
    return errorMessage;
  }

  static extractApiError(DioError error) {
    String message = "Something went wrong";
    print(
        'error === ${error.response}  ==== ${error.response != null ? error.response!.data : 'noresponse'} ==== ${error.response != null ? error.response!.extra : 'no response'}=== ${error.message}');
    if (error is DioError) {
      if (error.error is SocketException ||
          error.type == DioErrorType.connectTimeout) {
        message =
            "Cannot connect to server. Make sure you have proper internet connection";
      } else if (error.response != null &&
          error.response!.data['message'] != null) {
        message = error.response!.data['message'];
      } else if (error.message.isNotEmpty) {
        message = error.message;
      } else {
        message = error.response!.statusMessage ?? "Something went wrong";
      }
    }
    return message;
  }
}
