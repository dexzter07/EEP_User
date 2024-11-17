import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base_class/base_state.dart';
import '../infrastructure/repository/login_repository.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday



class LoginController extends StateNotifier<BaseState> {
  LoginController(this._ref) : super(InitialState());

  final Ref<dynamic> _ref;

  LoginRepository get _localAuthRepo => _ref.read(loginRepositoryProvider);

  Future<void> login(String mobileNumber, String password) async {
    final loginResponse = await _localAuthRepo.login(
      mobileNumber.contains('+977') ? mobileNumber : '+977$mobileNumber',
      password,
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  void _otpFailureToast(BuildContext context) =>
      context.showToast(message: "We faced some issue while sending OTP");
}
