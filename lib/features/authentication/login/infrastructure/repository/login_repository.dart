import 'package:dartz/dartz.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_class/failure_response.dart';
import '../response/login_response.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

final loginRepositoryProvider =
    Provider<LoginRepository>((ref) => LoginRepository(ref));

class LoginRepository {
  final Ref _ref;

  LoginRepository(this._ref);

  Future<Either<LoginResponse, FailureResponse>> login(
    String mobileNumber,
    String uuid,
  ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.login,
        data: {
          "phone_number": mobileNumber,
          "uuid": uuid,
        },
      );
      print('Response from server is : ${response.data}');
      final data =
          LoginResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse("Error"));
    }
  }
}
