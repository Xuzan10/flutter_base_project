import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mcn_app/api/api_service.dart';
import 'package:mcn_app/constants/constants.dart';
import 'package:mcn_app/di/module.dart';
import 'package:mcn_app/utils/error_helper.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio dio() => new Dio(BaseOptions(
          //todo setupbase helper
          baseUrl: API.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }))
        ..interceptors.add(InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          print(
              'interceptors ===  ${options.baseUrl} ===  ${options.path} ===  ${options.data} === ${options.headers}');
          return handler.next(options);
        }, onResponse:
            (Response response, ResponseInterceptorHandler handler) async {
          return handler.next(response);
        }, onError: (DioError error, ErrorInterceptorHandler handler) async {
          return handler.next(error);
        }));

  @lazySingleton
  ApiService apiService() => ApiService();
}
