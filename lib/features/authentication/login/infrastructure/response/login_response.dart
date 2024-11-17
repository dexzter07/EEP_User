
class LoginResponse {
  final String? message;
  final bool? isRegistered;
  final Token? token;

  LoginResponse({
    this.message,
    this.isRegistered,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      isRegistered: json['isRegistered'],
     /* restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((restaurant) => RestaurantResponse.fromJson(restaurant))
          .toList(),*/
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isRegistered': isRegistered,
      // 'restaurants': restaurants?.map((restaurant) => restaurant.toJson()).toList(),
      'token': token?.toJson(),
    };
  }
}

class Token {
  final String? refresh;
  final String? access;

  Token({
    this.refresh,
    this.access,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
      'access': access,
    };
  }
}
