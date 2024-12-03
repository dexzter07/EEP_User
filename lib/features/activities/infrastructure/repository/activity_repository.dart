import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/activities/infrastructure/fake_data.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_dropdown_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
        endPoint: Endpoints.createActivity,
        data: activityResponseData.toJson(),
      );
      final data = ActivityCreateResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<ActivityListResponse, FailureResponse>> fetchActivityList({
    int? pageNumber,
    int? activityType,
    int? userRestriction,
  }) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.get(
        endPoint: Endpoints.fetchActivityList,
        queryParams: {
          'limit': 5,
          'page': pageNumber ?? 1,
          'typeOfActivity': activityType ?? 0,
          // 0 - All, 1 - Upcoming, 2 - Past, 3 - Ongoing
          'userRestriction': userRestriction ?? 0,
          // 0 - All Users, 1 - Activities of logged in user
        },
      );
      final data =
          ActivityListResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<CommentListResponse, FailureResponse>> fetchCommentList(
    int activityId,
  ) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.get(
        endPoint: '${Endpoints.fetchCommentList}$activityId',
      );
      final data =
          CommentListResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Left(CommentListResponse.fromJson(fakeCommentListResponse));

      // return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<BaseSuccessResponse, FailureResponse>> getImageUrl(
    File imageFile,
  ) async {
    try {
      var mimeType =
          lookupMimeType(imageFile.path) ?? 'application/octet-stream';
      final apiClient = _ref.read(apiHelperProvider);
      var file = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      );
      FormData formData = FormData.fromMap({
        'file': file,
      });

      final response = await apiClient.post(
        endPoint: Endpoints.uploadImage,
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<ActivityDropDownResponse, FailureResponse>>
      fetchActivityDropdownList() async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.get(
        endPoint: Endpoints.fetchDropdownList,
      );
      final data = ActivityDropDownResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }
}
