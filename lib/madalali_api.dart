import 'package:dio/dio.dart';

//import 'errors/loggin_interceptor.dart';

//const String BASE_URL = "http://madalali.local:8888";

const String BASE_URL = "http://localhost:8000";
List<Interceptor> _interceptors = [
  //LoggingInterceptor(),
];

class MadalaliApi {
  static Dio getDio() {
    Dio dio = new Dio(_baseOptions);
    //dio.interceptors.addAll(_interceptors);
    return dio;
  }

  static  final BaseOptions _baseOptions =  BaseOptions(
    contentType: "application/json",
    baseUrl: BASE_URL,
    //receiveTimeout: 5000,
    //connectTimeout: 5000,
  );

  // For unauthenticated apis

  // Autheticated routes
  static Dio dioAuth() {
    return Dio();
  }
}
