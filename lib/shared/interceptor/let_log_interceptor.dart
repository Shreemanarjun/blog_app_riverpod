import 'package:dio/dio.dart';
import 'package:let_log/let_log.dart';

extension ResponseExtension on Response {
  int getStatusCode() {
    if (statusMessage == 'cache') {
      return 200;
    } else {
      return statusCode ?? 0;
    }
  }
}

class LetLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.net(
      options.path,
      type: options.method,
      data: options.data,
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.endNet(
      response.requestOptions.path,
      type: response.requestOptions.method,
      data: response.data,
      headers: response.headers,
      status: response.getStatusCode(),
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger.endNet(
      err.requestOptions.path,
      type: err.requestOptions.method,
      data: err.response?.data,
      headers: err.response?.headers,
      status: err.response != null ? err.response!.getStatusCode() : 0,
    );
    super.onError(err, handler);
  }
}
