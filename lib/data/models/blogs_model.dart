// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class BlogsModel {
  final List<BlogModel> blogs;
  BlogsModel({
    required this.blogs,
  });

  BlogsModel copyWith({
    List<BlogModel>? blogs,
  }) {
    return BlogsModel(
      blogs: blogs ?? this.blogs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blogs': blogs.map((x) => x.toMap()).toList(),
    };
  }

  factory BlogsModel.fromMap(Map<String, dynamic> map) {
    return BlogsModel(
      blogs: List<BlogModel>.from(map['blogs']?.map((x) => BlogModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogsModel.fromJson(String source) => BlogsModel.fromMap(json.decode(source));

  @override
  String toString() => 'BlogsModel(blogs: $blogs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BlogsModel &&
      listEquals(other.blogs, blogs);
  }

  @override
  int get hashCode => blogs.hashCode;
}

class BlogModel {
  final int id;
  final int user_id;
  final String body;
  final String title;
  BlogModel({
    required this.id,
    required this.user_id,
    required this.body,
    required this.title,
  });

  BlogModel copyWith({
    int? id,
    int? user_id,
    String? body,
    String? title,
  }) {
    return BlogModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      body: body ?? this.body,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'body': body,
      'title': title,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      body: map['body'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Blog(id: $id, user_id: $user_id, body: $body, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BlogModel &&
      other.id == id &&
      other.user_id == user_id &&
      other.body == body &&
      other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      body.hashCode ^
      title.hashCode;
  }
}