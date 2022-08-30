import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

void fixBadCertificate({required Dio dio}) {
  if (!kIsWeb) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return Platform.isAndroid;
      };
      return client;
    };
  }
}
