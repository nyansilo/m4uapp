import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

import '../config/application.dart';
import '../utils/utils.dart';
import 'exceptions/dio_exception.dart';
import 'interceptors/logger_interceptor.dart';

List<Interceptor> _interceptors = [
  //AuthorizationInterceptor(),
  LoggerInterceptor(),
];

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    //baseUrl: '${Application.domain}',
    baseUrl: 'http://localhost:8000',

    connectTimeout: 30000,
    receiveTimeout: 30000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  ///On change domain
  void changeDomain(String domain) {
    baseOptions.baseUrl = domain;
  }

  ///Setup Option
  BaseOptions exportOption(BaseOptions options) {
    Map<String, dynamic> header = {
      'Retry-After': 3600,
      //'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8',
      "Device-Id": Application.device?.uuid ?? '',
      "Device-Name": utf8.encode(Application.device?.name ?? ''),
      "Device-Model": Application.device?.model ?? '',
      "Device-Version": Application.device?.version ?? '',
      "Push-Token": Application.device?.token ?? '',
      "Type": Application.device?.type ?? '',
      //"Lang": AppBloc.languageCubit.state.languageCode,
    };
    options.headers.addAll(header);
    //UserModel? user = AppBloc.userCubit.state;
    //if (user == null) {
    // options.headers.remove("Authorization");
    //} else {
    //options.headers["Authorization"] = "Bearer ${user.token}";
    //}
    return options;
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data ?? formData);
    BaseOptions requestOptions = exportOption(baseOptions);
    UtilLogger.log("HEADERS", requestOptions.headers);

    Dio dio = Dio(requestOptions)..interceptors.addAll(_interceptors);

    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await dio.post(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (sent, total) {
          if (progress != null) {
            progress((sent / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      throw errorMessage;
      //return dioErrorHandle(error);
    } catch (e) {
      throw e.toString();
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Get method
  Future<Response> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
    bool? loading,
  }) async {
    UtilLogger.log("GET URL", url);
    UtilLogger.log("PARAMS", params);
    BaseOptions requestOptions = exportOption(baseOptions);
    UtilLogger.log("HEADERS", requestOptions.headers);

    Dio dio = Dio(requestOptions)..interceptors.addAll(_interceptors);
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
      );
      return response;
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      throw errorMessage;
      //return dioErrorHandle(error);
    } catch (e) {
      throw e.toString();
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
