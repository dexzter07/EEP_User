class CommentListResponse {
  String? status;
  List<CommentData>? data;

  CommentListResponse({this.status, this.data});

  factory CommentListResponse.fromJson(Map<String, dynamic> json) {
    return CommentListResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CommentData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class CommentData {
  int? id;
  bool? isMine;
  String? teacherName;
  String? comment;
  String? nameInitial;
  String? userImage;

  CommentData({
    this.id,
    this.isMine,
    this.teacherName,
    this.comment,
    this.nameInitial,
    this.userImage,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'] as int?,
      isMine: json['isMine'] as bool?,
      teacherName: json['teacherName'] as String?,
      comment: json['comment'] as String?,
      nameInitial: json['nameInitial'] as String?,
      userImage: json['userImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isMine': isMine,
      'teacherName': teacherName,
      'comment': comment,
      'nameInitial': nameInitial,
      'userImage': userImage,
    };
  }
}
