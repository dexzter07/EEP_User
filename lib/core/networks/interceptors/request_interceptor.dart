import 'package:dio/dio.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../local_data_source/local_data_source.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor(this._ref);

  final Ref _ref;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String accessToken =
          await _ref.read(localDataSourceProvider).getAccessToken();
      String tempAccessToken =
          await _ref.read(localDataSourceProvider).getTempAccessToken();

      if (_isSignUpPhase2or3Api(options) && tempAccessToken.isNotEmpty) {
        options.headers
            .putIfAbsent('Authorization', () => 'Bearer $tempAccessToken');
      } else if (accessToken.isNotEmpty) {
        options.headers
            .putIfAbsent('Authorization', () => 'Bearer $accessToken');
      } else if (tempAccessToken.isNotEmpty) {}
      // Handle null values in query parameters:
      options.queryParameters
          .removeWhere((key, value) => value == null || value == '');
    } catch (e) {
      debugPrint('Exception in Request Interceptor : $e');
    }
    super.onRequest(options, handler);
  }

  bool _isSignUpPhase2or3Api(RequestOptions options) {
    return (options.path == Endpoints.signupPhase2 ||
        options.path == Endpoints.signupPhase3);
  }
}
