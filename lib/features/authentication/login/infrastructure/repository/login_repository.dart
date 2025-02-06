import 'package:dartz/dartz.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/core/base_class/failure_response.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/authentication/login/infrastructure/request/login_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider =
    Provider<LoginRepository>((ref) => LoginRepository(ref));

class LoginRepository {
  final Ref _ref;

  LoginRepository(this._ref);

  Future<Either<BaseSuccessResponse, FailureResponse>> login(
    LoginRequest loginRequest,
  ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.login,
        data: loginRequest.toJson(),
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      print('asdad :$e');
      return Right(FailureResponse.getErrorMessage(e));
    }
  }
}
