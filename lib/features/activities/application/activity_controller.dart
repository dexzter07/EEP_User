import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/activities/infrastructure/repository/activity_repository.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
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
    final response = await _activityRepo.createActivity(activityResponseData);
    state = response.fold(
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
    final response = await _activityRepo.fetchActivityList(
      pageNumber,
      activityType,
    );
    state = response.fold(
      (success) {
        return SuccessState<ActivityListResponse>(data: success);
      },
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> fetchCommentList(int activityId) async {
    state = LoadingState();
    await Future.delayed(const Duration(seconds: 2));
    final response = await _activityRepo.fetchCommentList(activityId);
    state = response.fold(
      (success) => SuccessState<List<CommentData>?>(data: success.data),
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
