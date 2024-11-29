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
    return {
      'id': id,
      'activityTitle': activityTitle,
      'location': location,
      'activityDateAndTime': activityDateAndTime,
      'activityEndDateAndTime': activityEndDateAndTime,
      'description': description,
      'activityType': activityType,
      'image': image,
      'status': status,
      'userType': userType,
      'userImage': userImage,
      'userId': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'activityTypeName': activityTypeName,
      'totalLikes': totalLikes,
      'totalComment': totalComment,
      'isLiked': isLiked,
    };
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
