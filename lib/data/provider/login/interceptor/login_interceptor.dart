import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:dio/dio.dart';
import 'package:let_log/let_log.dart';

import 'login_api_error_handler.dart';

class LoginInteceptor extends Interceptor {
  late Dio dio;
  final IDbService dbService;
  LoginInteceptor({
    required this.dbService,
    required this.dio,
  });
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final data = options.data;
    if (data is FormData) {
      ///print form data
      data.fields.map((item) => Logger.log('${item.key} : ${item.value}'));
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handleLoginAPIError(err, handler, dio);
  }
}
