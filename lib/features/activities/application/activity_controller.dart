import 'dart:io';

import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/features/activities/infrastructure/repository/activity_repository.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_dropdown_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
import 'package:epp_user/features/activities/presentation/activity_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final activityDropDownListProvider = StateProvider((ref) => <ActivityData?>[]);

class ActivityController extends StateNotifier<BaseState> {
  ActivityController(this._ref) : super(InitialState());
  final Ref<dynamic> _ref;

  ActivityRepository get _activityRepo => _ref.read(activityRepositoryProvider);

  Future<void> createActivity(
    ActivityResponseData activityResponseData,
  ) async {
    state = LoadingState();
    String? uploadImageApiResponse;
    if (activityResponseData.image != null) {
      uploadImageApiResponse =
          await getImageUrl(File(activityResponseData.image!));
    }
    final response = await _activityRepo.createActivity(
      activityResponseData.copyWith(image: uploadImageApiResponse),
    );
    state = response.fold(
      (success) => SuccessState<ActivityCreateResponse>(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> fetchActivityList() async {
    state = LoadingState();
    final response = await _activityRepo.fetchActivityList(
      pageNumber: 1,
    );
    state = response.fold(
      (success) {
        _ref.read(activityListProvider.notifier).state.clear();
        _ref.read(activityListProvider.notifier).state = [
          ...success.data ?? []
        ];
        return SuccessState<ActivityListResponse>(data: success);
      },
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> loadMoreActivityList(int pageNumber) async {
    state = LoadingState();
    final response =
        await _activityRepo.fetchActivityList(pageNumber: pageNumber);
    state = response.fold(
      (success) {
        final oldData = _ref.read(activityListProvider);
        final newData = [
          ...oldData,
          ...success.data ?? [],
        ];
        _ref.read(activityListProvider.notifier).state = [...newData];
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

  Future<String?> getImageUrl(File imageFile) async {
    final response = await _activityRepo.getImageUrl(imageFile);
    return response.fold(
      (success) => success.fileUrl ?? '',
      (failure) => null,
    );
  }

  Future<void> fetchActivityDropdownList() async {
    print('asdasdas');
    final response = await _activityRepo.fetchActivityDropdownList();
    response.fold(
        (success) => _ref.read(activityDropDownListProvider.notifier).state =
            success.data ?? [],
        (failure) => null);
  }
}
