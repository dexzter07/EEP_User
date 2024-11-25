import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/activities/infrastructure/repository/activity_repository.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

class ActivityController extends StateNotifier<BaseState> {
  ActivityController(this._ref) : super(InitialState());
  final Ref<dynamic> _ref;

  ActivityRepository get _activityRepo => _ref.read(activityRepositoryProvider);

  Future<void> createActivity(
    ActivityResponseData activityResponseData,
  ) async {
    state = LoadingState();
    final loginResponse =
        await _activityRepo.createActivity(activityResponseData);
    state = loginResponse.fold(
      (success) => SuccessState<ActivityCreateResponse>(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> fetchActivityList(
    int pageNumber,
    int activityType,
  ) async {
    state = LoadingState();
    await Future.delayed(const Duration(seconds: 2));
    final loginResponse = await _activityRepo.fetchActivityList(
      pageNumber,
      activityType,
    );
    state = loginResponse.fold(
      (success) {
        return SuccessState<ActivityListResponse>(data: success);
      },
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
