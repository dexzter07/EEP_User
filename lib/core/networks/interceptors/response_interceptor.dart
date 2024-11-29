import 'package:dio/dio.dart';
import 'package:epp_user/core/local_data_source/local_data_source.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/13/2023, Wednesday

class ResponseInterceptor extends Interceptor {
  final Ref _ref;

  ResponseInterceptor(this._ref);

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    try {
      if (_isLoginApi(response) || _isSignUpPhase3Api(response)) {
        _saveAccessToken(response);
      } else if (_isSignUpPhase1or2Api(response)) {
        _saveTempAccessToken(response);
      }
      super.onResponse(response, handler);
      return;
    } catch (e) {
      super.onResponse(response, handler);
      return;
    }
  }

  void _saveAccessToken(Response<dynamic> response) {
    _ref.read(localDataSourceProvider).saveAccessToken(response.data['token']);
  }

  void _saveTempAccessToken(Response<dynamic> response) {
    _ref
        .read(localDataSourceProvider)
        .saveTempAccessToken(response.data['token']);
  }

  bool _isLoginApi(Response<dynamic> response) {
    return response.realUri.toString() ==
            '${Endpoints.baseUrl}${Endpoints.login}' &&
        response.data['token'] != null;
  }

  bool _isSignUpPhase1or2Api(Response<dynamic> response) {
    return (response.realUri.toString() ==
                '${Endpoints.baseUrl}${Endpoints.signupPhase1}' ||
            response.realUri.toString() ==
                '${Endpoints.baseUrl}${Endpoints.signupPhase2}') &&
        response.data['token'] != null;
  }

  bool _isSignUpPhase3Api(Response<dynamic> response) {
    return response.realUri.toString() ==
            '${Endpoints.baseUrl}${Endpoints.signupPhase3}' &&
        response.data['token'] != null;
  }
}
