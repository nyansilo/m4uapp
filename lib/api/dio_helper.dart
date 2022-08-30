import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static int() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8000',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? qurey,
    
  }) async {
    Response reposnse =  await dio!.get(
      url,
      queryParameters: qurey,
    );

    return reposnse;
  }

  factory DioHelper() {
    return DioHelper._internal();
  }

  DioHelper._internal();

   
}

DioHelper dioHelper = DioHelper();