import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Network {
  final _dio = Dio();

  Network() {
    _dio.interceptors.clear();

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
      debugPrint("Url : ${option.uri}");
      debugPrint("Data : ${option.data}");
      return handler.next(option);
    }, onResponse: (response, handler) async {
      // debugPrint("Response : ${response.data}");
      return handler.next(response);
    }, onError: (dioError, handler) async {
      debugPrint("Error : ${dioError.error}");
      return handler.next(dioError);
    }));

    _dio.options = BaseOptions(
      baseUrl: "https://itunes.apple.com",
      connectTimeout: 30000,
      receiveTimeout: 30000
    );
  }

  Future<Response?> get(String url,
      {Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        int cacheDays = 7,
        bool forceRefresh = true}) async {
    Response? response;
    try {
      response = await _dio.get(url,
          queryParameters: queryParameters);
    } on DioError catch (e) {
      return e.response;
    }
    return response;
  }
}
