import 'package:dio/dio.dart';
import 'package:epp_user/core/local_data_source/local_data_source.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/13/2023, Wednesday

class ResponseInterceptor extends Interceptor {
  final ProviderRef _ref;

  ResponseInterceptor(this._ref);

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    try {
      if (_isLoginApi(response)) {
        _saveAccessToken(response);
      }
      super.onResponse(response, handler);
      return;
    } catch (e) {
      super.onResponse(response, handler);
      return;
    }
  }

  void _saveAccessToken(Response<dynamic> response) {
    _ref
        .read(localDataSourceProvider)
        .saveAccessToken(response.data['token']['access']);
  }

  bool _isLoginApi(Response<dynamic> response) {
    return response.realUri.toString() ==
            '${Endpoints.baseUrl}${Endpoints.login}' &&
        response.data['token']['access'] != null;
  }
}
