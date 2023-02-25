import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:blog_app_riverpod/shared/dio_client/default_api_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DefaultAPIInterceptor extends Interceptor {
  final Dio dio;
  final IDbService dbService;
  DefaultAPIInterceptor({required this.dio, required this.dbService});
  final talker = Talker();
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final data = options.data;
    if (data is FormData) {
      ///print form data
      for (var item in data.fields) {
        talker.log('${item.key} : ${item.value}');
      }
    }
    final tokenmodel = await dbService.getTokenModel();
    if (tokenmodel != null) {
      final Map<String, dynamic> tokenHeader = {
        'Authorization': 'Bearer ${tokenmodel.accessToken}'
      };
      talker.log('token header $tokenHeader');
      options.headers.addAll(tokenHeader);
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    defaultAPIErrorHandler(err, handler, dio);
  }
}
