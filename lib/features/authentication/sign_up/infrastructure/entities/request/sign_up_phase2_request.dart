class SignUpPhase2Request {
  final String? schoolName;
  final String? schoolType;
  final String? schoolAffiliation;
  final String? schoolAddress;

  SignUpPhase2Request({
    this.schoolName,
    this.schoolType,
    this.schoolAffiliation,
    this.schoolAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'schoolType': schoolType,
      'schoolAffiliation': schoolAffiliation,
      'schoolAddress': schoolAddress,
    };
  }
}
