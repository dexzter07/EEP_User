import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'endpoint.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'network_constant.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/18/2023, Monday


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = Endpoints.baseUrl;
  dio.options.connectTimeout = NetworkConstant.connectionTimeout;
  dio.options.receiveTimeout = NetworkConstant.receiveTimeout;
  dio.interceptors.addAll([
    if (kDebugMode)
      LogInterceptor(
        requestBody: true,
        requestHeader: true,
        request: true,
        responseBody: true,
      ),
    RequestInterceptor(ref),
    ResponseInterceptor(ref),
    ErrorInterceptor(ref),
    // AliceSetup().alice.getDioInterceptor(),
  ]);
  return dio;
});
