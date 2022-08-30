import 'dart:convert';

class LoginModel {
  final String accesstoken;
  final String tokentype;
  LoginModel({
    required this.accesstoken,
    required this.tokentype,
  });

  LoginModel copyWith({
    String? accesstoken,
    String? tokentype,
  }) {
    return LoginModel(
      accesstoken: accesstoken ?? this.accesstoken,
      tokentype: tokentype ?? this.tokentype,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accesstoken,
      'token_type': tokentype,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      accesstoken: map['access_token'] ?? '',
      tokentype: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModel(access_token: $accesstoken, token_type: $tokentype)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel &&
        other.accesstoken == accesstoken &&
        other.tokentype == tokentype;
  }

  @override
  int get hashCode => accesstoken.hashCode ^ tokentype.hashCode;
}
