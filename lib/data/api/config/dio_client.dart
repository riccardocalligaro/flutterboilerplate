import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate_starter/core/log/logger.dart';

import 'api_config.dart';
import 'interceptor/dio_request_retrier.dart';
import 'interceptor/retry_incerceptor.dart';

class DioClient {
  Dio createDio() {
    BaseOptions options = new BaseOptions(
      baseUrl: ApiConfig.API_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    final dio = Dio(options);

    if (kDebugMode && Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    dio.interceptors.add(InterceptorsWrapper(onResponse: (Response response) {
      Logger.debug(
        'DioEND -> Response -> ${response.statusCode} [${response.request.path}] ${response.request.method}  ${response.request.responseType}',
      );

      return response; // continue
    }, onError: (DioError error) async {
      Logger.networkError(
        'Dio error: ${error.type}',
        Exception(
          'Url: [${error.request.baseUrl}] status:${error.response.statusCode} type:${error.type} message: ${error.message}',
        ),
      );
      // if (error != SocketException) {
      //   // Log su crashlytics
      //   // Crashlytics.instance.recordError(error, StackTrace.current);
      // }
    }));

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    return dio;
  }
}
