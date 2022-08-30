import 'dart:convert';

class SignupModel {
  final String email;
  final int id;
  final String password;
  final String name;
  SignupModel({
    required this.email,
    required this.id,
    required this.password,
    required this.name,
  });

  SignupModel copyWith({
    String? email,
    int? id,
    String? password,
    String? name,
  }) {
    return SignupModel(
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'password': password,
      'name': name,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      email: map['email'] ?? '',
      id: map['id']?.toInt() ?? 0,
      password: map['password'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) => SignupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignupModel(email: $email, id: $id, password: $password, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SignupModel &&
      other.email == email &&
      other.id == id &&
      other.password == password &&
      other.name == name;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      id.hashCode ^
      password.hashCode ^
      name.hashCode;
  }
}