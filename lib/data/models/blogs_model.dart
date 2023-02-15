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
  final String title;
  final String createdAt;
  final String updatedAt;
  final int userID;
  BlogModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.userID,
  });

  BlogModel copyWith({
    int? id,
    String? title,
    String? createdAt,
    String? updatedAt,
    int? userID,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userID': userID,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      userID: map['userID']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Blog(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, userID: $userID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BlogModel &&
      other.id == id &&
      other.title == title &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.userID == userID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      userID.hashCode;
  }
}