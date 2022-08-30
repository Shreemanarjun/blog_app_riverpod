import 'package:blog_app_riverpod/data/provider/blog_api/interceptor/blog_api_error_handler.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:dio/dio.dart';
import 'package:let_log/let_log.dart';

class BlogInteceptor extends Interceptor {
  late Dio dio;
  final IDbService dbService;
  BlogInteceptor({
    required this.dbService,
    required this.dio,
  });
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final data = options.data;
    if (data is FormData) {
      ///print form data
      for (var item in data.fields) {
        Logger.log('${item.key} : ${item.value}');
      }
    }
    final loginmodel = await dbService.readLoginModel();
    final Map<String, dynamic> tokenHeader = {
      'Authorization': 'Bearer ${loginmodel?.accesstoken}'
    };
    Logger.log('token header $tokenHeader');
    options.headers.addAll(tokenHeader);

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handleBlogAPIError(err, handler, dio);
  }
}
