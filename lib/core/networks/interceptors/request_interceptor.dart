import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../local_data_source/local_data_source.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/13/2023, Wednesday

class RequestInterceptor extends Interceptor {
  RequestInterceptor(this._ref);

  final ProviderRef _ref;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String accessToken =
          await _ref.read(localDataSourceProvider).getAccessToken();
      if (accessToken.isNotEmpty) {
        options.headers
            .putIfAbsent('Authorization', () => 'Bearer $accessToken');
      }
      // Handle null values in query parameters:
      options.queryParameters
          .removeWhere((key, value) => value == null || value == '');
    } catch (e) {
      debugPrint('Exception in Request Interceptor : $e');
    }
    super.onRequest(options, handler);
  }
}
