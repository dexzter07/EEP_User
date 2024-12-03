import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/core/base_class/failure_response.dart';
import 'package:epp_user/core/networks/api_helper.dart';
import 'package:epp_user/core/networks/endpoint.dart';
import 'package:epp_user/features/profile/infrastructure/response/profile_details_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) => ProfileRepository(ref));

class ProfileRepository {
  final Ref _ref;

  ProfileRepository(this._ref);

  Future<Either<ProfileDetailsResponse, FailureResponse>>
      fetchProfileDetails() async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.get(
        endPoint: Endpoints.fetchProfileDetails,
      );
      final data = ProfileDetailsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<BaseSuccessResponse, FailureResponse>> updateProfileDetails({
    ProfileData? profileData,
  }) async {
    try {
      final apiClient = _ref.read(apiHelperProvider);
      final response = await apiClient.post(
        endPoint: Endpoints.updateProfile,
        data: profileData?.toJson(),
        isPut: true,
      );
      final data =
          BaseSuccessResponse.fromJson(response.data as Map<String, dynamic>);
      return Left(data);
    } catch (e) {
      return Right(FailureResponse.getErrorMessage(e));
    }
  }

  Future<Either<BaseSuccessResponse, FailureResponse>> uploadProfilePicture(
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
        endPoint: Endpoints.uploadProfilePicture,
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
}
