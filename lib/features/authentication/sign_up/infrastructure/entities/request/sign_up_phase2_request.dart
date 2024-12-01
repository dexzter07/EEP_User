class SignUpPhase2Request {
  final String? schoolName;
  final String? schoolType;
  final String? schoolAffiliation;
  final String? state;
  final String? district;
  final String? pincode;

  SignUpPhase2Request({
    this.schoolName,
    this.schoolType,
    this.schoolAffiliation,
    this.state,
    this.district,
    this.pincode,
  });

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'schoolType': schoolType,
      'schoolAffiliation': schoolAffiliation,
      'state': state,
      'district': district,
      'pincode': pincode,
    };
  }
}
