import 'package:dartz/dartz.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/core/base_class/failure_response.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase1_request.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase2_request.dart';
import 'package:epp_user/features/authentication/sign_up/infrastructure/entities/request/sign_up_phase3_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

final signupRepositoryProvider =
    Provider<SignupRepository>((ref) => SignupRepository(ref));

class SignupRepository {
  final Ref _ref;

  SignupRepository(this._ref);

  Future<Either<BaseSuccessResponse, FailureResponse>> signupPhase1Api(
      SignUpPhase1Request signUpPhase1Request) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.signupPhase1,
        data: signUpPhase1Request.toJson(),
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<BaseSuccessResponse, FailureResponse>> signupPhase2Api(
      SignUpPhase2Request signUpPhase2Request) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.signupPhase2,
        data: signUpPhase2Request.toJson(),
        isPut: true,
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<BaseSuccessResponse, FailureResponse>> signupPhase3Api(
      SignUpPhase3Request signUpPhase3Request) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.signupPhase3,
        data: signUpPhase3Request.toJson(),
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }
}
