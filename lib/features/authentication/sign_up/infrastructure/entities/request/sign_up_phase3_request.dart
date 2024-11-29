class SignUpPhase3Request {
  final String? principalName;
  final String? email;
  final String? phone;

  SignUpPhase3Request({
    this.principalName,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'principalName': principalName,
      'email': email,
      'phone': phone,
    };
  }
}
