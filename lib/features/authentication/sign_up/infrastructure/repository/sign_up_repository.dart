import 'package:dartz/dartz.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/authentication/login/infrastructure/response/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_class/failure_response.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

final signupRepositoryProvider =
Provider<SignupRepository>((ref) => SignupRepository(ref));

class SignupRepository {
  final Ref _ref;
  SignupRepository(this._ref);
  Future<Either<LoginResponse, FailureResponse>> signupApi1(
      String mobileNumber,
      String uuid,
      ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.signup1,
        data: {
          "phone_number": mobileNumber,
          "uuid": uuid,
        },
      );
      final data =
      LoginResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse("Error"));
    }
  }
}
