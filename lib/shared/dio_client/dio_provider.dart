import 'dart:io';

import 'package:blog_app_riverpod/data/const/app_urls.dart';
import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:blog_app_riverpod/shared/dio_client/default_api_interceptor.dart';
import 'package:blog_app_riverpod/shared/helper/bad_certificate_fixer.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dioProvider = Provider.autoDispose((ref) {
  final Dio dio = Dio();
  dio.options.baseUrl = AppURLs.baseUrl;

  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
        printRequestData: true,
        printResponseData: true,
      ),
    ),
  );
  dio.interceptors.addAll([
    InterceptorsWrapper(
      onError: (e, handler) async {
        if (e.response!.statusCode == 401) {
          await ref.read(dbServiceProvider).removeTokenModel();
          await ref.read(autorouterProvider).replaceAll([
            const LoginRouter(),
          ]);
        }
        handler.next(e);
      },
    ),
    DefaultAPIInterceptor(dio: dio, dbService: ref.watch(dbServiceProvider)),
    RetryInterceptor(
        dio: dio,
        //   logPrint: talker.log, // specify log function (optional)
        // retry count (optional)
        retries: 2,
        retryDelays: [
          const Duration(seconds: 2),
          const Duration(seconds: 4),
          const Duration(seconds: 6),
        ],
        retryEvaluator: (error, i) {
          // only retry on DioError
          if (error.error is SocketException) {
            // only retry on timeout error
            return true;
          } else {
            return false;
          }
        }),
  ]);
  fixBadCertificate(dio: dio);
  return dio;
});
