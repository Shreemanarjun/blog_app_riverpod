// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class CreateBlogResponseModel {
  final String body;
  final int id;
  final int user_id;
  final String title;
  CreateBlogResponseModel({
    required this.body,
    required this.id,
    required this.user_id,
    required this.title,
  });

  CreateBlogResponseModel copyWith({
    String? body,
    int? id,
    int? user_id,
    String? title,
  }) {
    return CreateBlogResponseModel(
      body: body ?? this.body,
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'id': id,
      'user_id': user_id,
      'title': title,
    };
  }

  factory CreateBlogResponseModel.fromMap(Map<String, dynamic> map) {
    return CreateBlogResponseModel(
      body: map['body'] ?? '',
      id: map['id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBlogResponseModel.fromJson(String source) => CreateBlogResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateBlogResponseModel(body: $body, id: $id, user_id: $user_id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CreateBlogResponseModel &&
      other.body == body &&
      other.id == id &&
      other.user_id == user_id &&
      other.title == title;
  }

  @override
  int get hashCode {
    return body.hashCode ^
      id.hashCode ^
      user_id.hashCode ^
      title.hashCode;
  }
}