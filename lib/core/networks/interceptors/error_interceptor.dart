import 'package:dio/dio.dart';
import 'package:epp_user/app/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/13/2023, Wednesday

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response != null &&
        err.response?.statusCode != null &&
        err.response!.statusCode! == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.loginScreen,
        (Route<dynamic> route) => false,
      );
    }
  }
}
