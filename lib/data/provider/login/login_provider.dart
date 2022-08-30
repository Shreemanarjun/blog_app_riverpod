import 'package:blog_app_riverpod/data/const/app_urls.dart';
import 'package:blog_app_riverpod/data/provider/login/interceptor/login_interceptor.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:dio/dio.dart';

import 'i_login_provider.dart';

class LoginProvider implements ILoginProvider {
  final IDbService dbService;
  final Dio dio;
  LoginProvider({required this.dbService, required this.dio}) {
    dio.interceptors.add(
      LoginInteceptor(
        dio: dio,
        dbService: dbService,
      ),
    );
  }
  @override
  Future<Response> loginUser(
      {required String username, required String password}) async {
    return await dio.post(
      AppURLs.loginUrl,
      options: Options(
        validateStatus: (status) => status == 200,
      ),
      data: FormData.fromMap(
        {
          'username': username,
          'password': password,
        },
      ),
    );
  }

  @override
  Future<Response> signUpUser(
      {required String name, required String email, required String password}) {
    return dio.post(AppURLs.signupUrl, data: {
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
