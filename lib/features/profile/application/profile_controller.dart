import 'dart:io';

import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/features/activities/infrastructure/repository/activity_repository.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_dropdown_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
import 'package:epp_user/features/activities/presentation/activity_list_screen.dart';
import 'package:epp_user/features/profile/infrastructure/repository/profile_repository.dart';
import 'package:epp_user/features/profile/infrastructure/response/profile_details_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

class ProfileController extends StateNotifier<BaseState> {
  ProfileController(this._ref) : super(InitialState());
  final Ref<dynamic> _ref;

  ProfileRepository get _profileRepo => _ref.read(profileRepositoryProvider);

  Future<void> fetchProfileDetails() async {
    state = LoadingState();
    final response = await _profileRepo.fetchProfileDetails();
    state = response.fold(
      (success) => SuccessState<ProfileData?>(data: success.data),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> updateProfile({
    ProfileData? profileData,
  }) async {
    state = LoadingState();
    final response =
        await _profileRepo.updateProfileDetails(profileData: profileData);
    state = response.fold(
      (success) => SuccessState<BaseSuccessResponse>(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }

  Future<void> uploadProfilePicture(File imageFile) async {
    state = LoadingState();
    final response = await _profileRepo.uploadProfilePicture(imageFile);
    state = response.fold(
      (success) => SuccessState<BaseSuccessResponse>(data: success),
      (failure) => FailureState(failureResponse: failure),
    );
  }
}
