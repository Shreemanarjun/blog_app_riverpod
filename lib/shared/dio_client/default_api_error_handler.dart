
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:let_log/let_log.dart';

void defaultAPIErrorHandler(
    DioError err, ErrorInterceptorHandler handler, Dio dio) async {
  Logger.log(err.type);
  switch (err.type) {
    case DioErrorType.connectTimeout:
      handler.resolve(Response(
          data: {'detail': 'connect timeout error'},
          requestOptions: err.requestOptions));
      break;
    case DioErrorType.sendTimeout:
      handler.resolve(Response(
          data: {'detail': 'sending data is slow'},
          requestOptions: err.requestOptions));
      break;
    case DioErrorType.receiveTimeout:
      handler.resolve(Response(
          data: {'detail': 'receiving data is slow'},
          requestOptions: err.requestOptions));
      break;
    case DioErrorType.response:
      if (err.response!.statusCode == 404) {
        handler.resolve(Response(data: {
          'detail': 'server error: status code ${err.response!.statusCode}'
        }, requestOptions: RequestOptions(path: err.requestOptions.path)));
      } else {
        handler.resolve(err.response ??
            Response(
                data: {'detail': 'response error'},
                requestOptions: err.requestOptions));
      }
      break;
    case DioErrorType.cancel:
      handler.resolve(Response(
          data: {'detail': 'user cancelled request'},
          requestOptions: err.requestOptions));
      break;
    case DioErrorType.other:
      if (err.error is SocketException) {
        handler.resolve(Response(
            data: {'detail': 'No Internet'},
            requestOptions: err.requestOptions));
      } else {
        handler.resolve(Response(
            data: {'detail': 'other error'},
            requestOptions: err.requestOptions));
      }
      break;
  }
}
