import 'package:dartz/dartz.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/base_class/failure_response.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final activityRepositoryProvider =
    Provider<ActivityRepository>((ref) => ActivityRepository(ref));

class ActivityRepository {
  final Ref _ref;

  ActivityRepository(this._ref);

  Future<Either<ActivityCreateResponse, FailureResponse>> createActivity(
    ActivityResponseData activityResponseData,
  ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.login,
        data: activityResponseData.toJson(),
      );
      final data = ActivityCreateResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Left(data);
    } catch (e) {
      return Right(FailureResponse("Error"));
    }
  }

  Future<Either<ActivityListResponse, FailureResponse>> fetchActivityList(
    int pageNumber,
    int activityType,
  ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.get(
        endPoint: Endpoints.login,
        queryParams: {
          'limit': 10,
          'page': pageNumber,
          'typeOfActivity': activityType,
        },
      );
      final data =
          ActivityListResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse("Error"));
    }
  }
}
