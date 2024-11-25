import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/repository/sign_up_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

class SignupController extends StateNotifier<BaseState> {
  SignupController(this._ref) : super(InitialState());
  final Ref<dynamic> _ref;

  SignupRepository get _localAuthRepo => _ref.read(signupRepositoryProvider);

  Future<void> signupApi1(String mobileNumber, String password) async {
    state = LoadingState();
    final loginResponse = await _localAuthRepo.signupApi1(
      mobileNumber.contains('+977') ? mobileNumber : '+977$mobileNumber',
      password,
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
