import 'package:dio/dio.dart';
import 'app_links.dart';

class DioClient {
  final Dio dio;

  DioClient._internal(this.dio) {
    dio.options.baseUrl = AppLinks.baseUrl;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request[${options.method}]: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response[${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('Error[${error.response?.statusCode}]: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  static final DioClient _instance = DioClient._internal(Dio());
  factory DioClient() => _instance;
}
