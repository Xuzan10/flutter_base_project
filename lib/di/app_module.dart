import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mcn_app/constants/constants.dart';
import 'package:mcn_app/utils/error_helper.dart';

abstract class AppModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(
          baseUrl: API.baseUrl,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }))
        ..interceptors.add(InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          print(
              'interceptors ===  ${options.baseUrl} ===  ${options.path} ===  ${options.data}');
        }, onError: (DioError error, ErrorInterceptorHandler handler) async {
          return ErrorHelper.extractApiError(error);
        }));
}
