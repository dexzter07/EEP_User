import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/authentication/login/infrastructure/request/login_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/repository/login_repository.dart';

class LoginController extends StateNotifier<BaseState> {
  LoginController(this._ref) : super(InitialState());

  final Ref<dynamic> _ref;

  LoginRepository get _localAuthRepo => _ref.read(loginRepositoryProvider);

  Future<void> login({
    String? phone,
    String? password,
  }) async {
    state = LoadingState();
    final loginResponse = await _localAuthRepo.login(
      LoginRequest(
        phone: phone,
        password: password,
        fcmToken: 'fcmToken',
      ),
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
