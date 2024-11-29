class SignUpPhase1Request {
  final String? teacherName;
  final String? teacherEmail;
  final String? teacherPhone;
  final String? password;
  final String? fcmToken;

  SignUpPhase1Request({
    this.teacherName,
    this.teacherEmail,
    this.teacherPhone,
    this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'teacherName': teacherName,
      'teacherEmail': teacherEmail,
      'teacherPhone': teacherPhone,
      'password': password,
      'fcmToken': fcmToken,
    };
  }
}
