import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase1_request.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase2_request.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase3_request.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/repository/sign_up_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

class SignupController extends StateNotifier<BaseState> {
  SignupController(this._ref) : super(InitialState());
  final Ref<dynamic> _ref;

  SignupRepository get _localAuthRepo => _ref.read(signupRepositoryProvider);

  Future<void> signupApi1({
    String? teacherName,
    String? teacherEmail,
    String? teacherPhone,
    String? password,
  }) async {
    state = LoadingState();
    final loginResponse = await _localAuthRepo.signupPhase1Api(
      SignUpPhase1Request(
        teacherName: teacherName,
        teacherEmail: teacherEmail,
        teacherPhone: teacherPhone,
        password: password,
        fcmToken: 'fcmToken',
      ),
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> signupApi2({
    String? schoolName,
    String? schoolType,
    String? schoolAffiliation,
    String? stateName,
    String? district,
    String? pincode,
  }) async {
    state = LoadingState();
    final loginResponse = await _localAuthRepo.signupPhase2Api(
      SignUpPhase2Request(
        schoolName: schoolName,
        schoolType: schoolType,
        schoolAffiliation: schoolAffiliation,
        state: stateName,
        district: district,
        pincode: pincode,
      ),
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> signupApi3({
    String? principalName,
    String? email,
    String? phone,
  }) async {
    state = LoadingState();
    final loginResponse = await _localAuthRepo.signupPhase3Api(
      SignUpPhase3Request(
        principalName: principalName,
        email: email,
        phone: phone,
      ),
    );
    state = loginResponse.fold(
      (success) => SuccessState(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
