import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CancelTokenExtension on AutoDisposeRef {
  /// creates a token to cancel API requests
  CancelToken cancelToken() {
    var token = CancelToken();
    onCancel(token.cancel);
    return token;
  }
}