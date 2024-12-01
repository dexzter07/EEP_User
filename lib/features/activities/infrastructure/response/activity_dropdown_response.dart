class ActivityDropDownResponse {
  final String? status;
  final List<ActivityData?>? data;

  ActivityDropDownResponse({
    this.status,
    this.data,
  });

  factory ActivityDropDownResponse.fromJson(Map<String, dynamic> json) {
    return ActivityDropDownResponse(
      status: json['status'],
      data: (json['data'] as List)
          .map((item) => ActivityData.fromJson(item))
          .toList(),
    );
  }
}

class ActivityData {
  final int? id;
  final String? title;

  ActivityData({
    this.id,
    this.title,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      id: json['id'],
      title: json['title'],
    );
  }
}
