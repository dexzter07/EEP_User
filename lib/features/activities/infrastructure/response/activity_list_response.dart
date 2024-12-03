class ActivityListResponse {
  final String? status;
  final List<ActivityResponseData>? data;
  final Pagination? pagination;

  ActivityListResponse({
    this.status,
    this.data,
    this.pagination,
  });

  factory ActivityListResponse.fromJson(Map<String, dynamic> json) {
    return ActivityListResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) =>
              ActivityResponseData.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class ActivityResponseData {
  final int? id;
  final String? activityTitle;
  final String? location;
  final String? activityDateAndTime;
  final String? activityEndDateAndTime;
  final String? description;
  final int? activityType;
  final String? image;
  final String? status;
  final String? userType;
  String? userImage;

  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final String? activityTypeName;
  final int? totalLikes;
  final int? totalComment;
  final bool? isLiked;

  ActivityResponseData({
    this.id,
    this.activityTitle,
    this.location,
    this.activityDateAndTime,
    this.activityEndDateAndTime,
    this.description,
    this.activityType,
    this.image,
    this.status,
    this.userType,
    this.userImage,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.activityTypeName,
    this.totalLikes,
    this.totalComment,
    this.isLiked,
  });

  ActivityResponseData copyWith({
    int? id,
    String? activityTitle,
    String? location,
    String? activityDateAndTime,
    String? activityEndDateAndTime,
    String? description,
    int? activityType,
    String? image,
    String? status,
    String? userType,
    String? userImage,
    int? userId,
    String? createdAt,
    String? updatedAt,
    String? activityTypeName,
    int? totalLikes,
    int? totalComment,
    bool? isLiked,
  }) {
    return ActivityResponseData(
      id: id ?? this.id,
      activityTitle: activityTitle ?? this.activityTitle,
      location: location ?? this.location,
      activityDateAndTime: activityDateAndTime ?? this.activityDateAndTime,
      activityEndDateAndTime:
          activityEndDateAndTime ?? this.activityEndDateAndTime,
      description: description ?? this.description,
      activityType: activityType ?? this.activityType,
      image: image ?? this.image,
      status: status ?? this.status,
      userType: userType ?? this.userType,
      userImage: userImage ?? this.userImage,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      activityTypeName: activityTypeName ?? this.activityTypeName,
      totalLikes: totalLikes ?? this.totalLikes,
      totalComment: totalComment ?? this.totalComment,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory ActivityResponseData.fromJson(Map<String, dynamic> json) {
    return ActivityResponseData(
      id: json['id'] as int?,
      activityTitle: json['activityTitle'] as String?,
      location: json['location'] as String?,
      activityDateAndTime: json['activityDateAndTime'] as String?,
      activityEndDateAndTime: json['activityEndDateAndTime'] as String?,
      description: json['description'] as String?,
      activityType: json['activityType'] as int?,
      image: json['image'] as String?,
      status: json['status'] as String?,
      userType: json['userType'] as String?,
      userImage: json['userImage'] as String?,
      userId: json['userId'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activityTypeName: json['activityTypeName'] as String?,
      totalLikes: json['totalLikes'] as int?,
      totalComment: json['totalComment'] as int?,
      isLiked: json['isLiked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (activityTitle != null) data['activityTitle'] = activityTitle;
    if (location != null) data['location'] = location;
    if (activityDateAndTime != null)
      data['activityDateAndTime'] = activityDateAndTime;
    if (activityEndDateAndTime != null)
      data['activityEndDateAndTime'] = activityEndDateAndTime;
    if (description != null) data['description'] = description;
    if (activityType != null) data['activityType'] = activityType;
    if (image != null) data['image'] = image;
    if (status != null) data['status'] = status;
    if (userType != null) data['userType'] = userType;
    if (userImage != null) data['userImage'] = userImage;
    if (userId != null) data['userId'] = userId;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    if (activityTypeName != null) data['activityTypeName'] = activityTypeName;
    if (totalLikes != null) data['totalLikes'] = totalLikes;
    if (totalComment != null) data['totalComment'] = totalComment;
    if (isLiked != null) data['isLiked'] = isLiked;

    return data;
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? totalCount;
  final int? totalPages;

  Pagination({
    this.page,
    this.limit,
    this.totalCount,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }
}
