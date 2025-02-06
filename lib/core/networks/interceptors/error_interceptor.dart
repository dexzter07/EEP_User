import 'package:dio/dio.dart';
import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      if (err.response?.statusCode == 401) {
        if (_isFromAuthApi(err)) {
          //Avoiding redirection to login screen if the user is in otp screen (for secondary device case)..
          super.onError(err, handler);
        } else {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.loginScreen,
            (Route<dynamic> route) => false,
          );
          super.onError(err, handler);
        }
      } else {
        super.onError(err, handler);
      }
    } catch (e) {
      super.onError(err, handler);
    }
  }

  bool _isFromAuthApi(DioException error) {
    return error.requestOptions.uri.toString().contains(Endpoints.login);
  }
}
