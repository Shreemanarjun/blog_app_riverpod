import 'dart:convert';

import 'package:flutter/foundation.dart';

class ValidationError {
  final List<Detail> detail;
  ValidationError({
    required this.detail,
  });

  ValidationError copyWith({
    List<Detail>? detail,
  }) {
    return ValidationError(
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail.map((x) => x.toMap()).toList(),
    };
  }

  factory ValidationError.fromMap(Map<String, dynamic> map) {
    return ValidationError(
      detail: List<Detail>.from(map['detail']?.map((x) => Detail.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationError.fromJson(String source) => ValidationError.fromMap(json.decode(source));

  @override
  String toString() => 'ValidationError(detail: $detail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ValidationError &&
      listEquals(other.detail, detail);
  }

  @override
  int get hashCode => detail.hashCode;
}

class Detail {
  final List<String> loc;
  final String msg;
  final String type;
  Detail({
    required this.loc,
    required this.msg,
    required this.type,
  });

  Detail copyWith({
    List<String>? loc,
    String? msg,
    String? type,
  }) {
    return Detail(
      loc: loc ?? this.loc,
      msg: msg ?? this.msg,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loc': loc,
      'msg': msg,
      'type': type,
    };
  }

  factory Detail.fromMap(Map<String, dynamic> map) {
    return Detail(
      loc: List<String>.from(map['loc']),
      msg: map['msg'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Detail.fromJson(String source) => Detail.fromMap(json.decode(source));

  @override
  String toString() => 'Detail(loc: $loc, msg: $msg, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Detail &&
      listEquals(other.loc, loc) &&
      other.msg == msg &&
      other.type == type;
  }

  @override
  int get hashCode => loc.hashCode ^ msg.hashCode ^ type.hashCode;
}