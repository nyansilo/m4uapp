import 'package:dio/dio.dart';

import 'interceptors/logger_interceptor.dart';

const String BASE_URL = "http://localhost:8000";
List<Interceptor> _interceptors = [
  //AuthorizationInterceptor(),
  LoggerInterceptor(),
];

class M4uApi {
  static Dio getDio() {
    Dio dio = Dio(_baseOptions);
    dio.interceptors.addAll(_interceptors);
    return dio;
  }

  static final BaseOptions _baseOptions = BaseOptions(
    contentType: "application/json",
    baseUrl: BASE_URL,
    //receiveTimeout: 5000,
    //connectTimeout: 5000,
  );
}
