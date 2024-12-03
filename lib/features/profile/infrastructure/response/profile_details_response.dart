class ProfileDetailsResponse {
  String? status;
  ProfileData? data;

  ProfileDetailsResponse({
    this.status,
    this.data,
  });

  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsResponse(
      status: json['status'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class ProfileData {
  int? id;
  String? teacherName;
  String? userImage;
  String? teacherEmail;
  int? teacherPhone;
  String? schoolName;
  String? schoolType;
  String? schoolAffiliation;
  String? state;
  String? district;
  String? pincode;
  String? principalName;
  String? principalEmail;
  int? principalPhone;
  int? enrolledCount;

  ProfileData({
    this.id,
    this.teacherName,
    this.userImage,
    this.teacherEmail,
    this.teacherPhone,
    this.schoolName,
    this.schoolType,
    this.schoolAffiliation,
    this.state,
    this.district,
    this.pincode,
    this.principalName,
    this.principalEmail,
    this.principalPhone,
    this.enrolledCount,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      teacherName: json['teacherName'],
      userImage: json['userImage'],
      teacherEmail: json['teacherEmail'],
      teacherPhone: json['teacherPhone'],
      schoolName: json['schoolName'],
      schoolType: json['schoolType'],
      schoolAffiliation: json['schoolAffiliation'],
      state: json['state'],
      district: json['district'],
      pincode: json['pincode'],
      principalName: json['principalName'],
      principalEmail: json['principalEmail'],
      principalPhone: json['principalPhone'],
      enrolledCount: json['enrolledCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacherName': teacherName,
      'userImage': userImage,
      'teacherEmail': teacherEmail,
      'teacherPhone': teacherPhone,
      'schoolName': schoolName,
      'schoolType': schoolType,
      'schoolAffiliation': schoolAffiliation,
      'state': state,
      'district': district,
      'pincode': pincode,
      'principalName': principalName,
      'principalEmail': principalEmail,
      'principalPhone': principalPhone,
      'enrolledCount': enrolledCount,
    }..removeWhere((key, value) => value == null);
  }

  /// Creates a copy of this object with given fields replaced.
  ProfileData copyWith({
    int? id,
    String? teacherName,
    String? userImage,
    String? teacherEmail,
    int? teacherPhone,
    String? schoolName,
    String? schoolType,
    String? schoolAffiliation,
    String? state,
    String? district,
    String? pincode,
    String? principalName,
    String? principalEmail,
    int? principalPhone,
    int? enrolledCount,
  }) {
    return ProfileData(
      id: id ?? this.id,
      teacherName: teacherName ?? this.teacherName,
      userImage: userImage ?? this.userImage,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      teacherPhone: teacherPhone ?? this.teacherPhone,
      schoolName: schoolName ?? this.schoolName,
      schoolType: schoolType ?? this.schoolType,
      schoolAffiliation: schoolAffiliation ?? this.schoolAffiliation,
      state: state ?? this.state,
      district: district ?? this.district,
      pincode: pincode ?? this.pincode,
      principalName: principalName ?? this.principalName,
      principalEmail: principalEmail ?? this.principalEmail,
      principalPhone: principalPhone ?? this.principalPhone,
      enrolledCount: enrolledCount ?? this.enrolledCount,
    );
  }
}
