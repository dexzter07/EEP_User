class LoginRequest {
  final String? phone;
  final String? password;
  final String? fcmToken;

  LoginRequest({
    this.phone,
    this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'fcmToken': fcmToken,
    };
  }
}
