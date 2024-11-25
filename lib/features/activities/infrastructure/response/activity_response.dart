import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';

class ActivityCreateResponse {
  final String? status;
  final String? message;
  final ActivityResponseData? data;

  ActivityCreateResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ActivityCreateResponse.fromJson(Map<String, dynamic> json) {
    return ActivityCreateResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ActivityResponseData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
