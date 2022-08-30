import 'package:blog_app_riverpod/data/models/login_model.dart';
import 'package:blog_app_riverpod/data/models/signup_model.dart';

import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginRepository {
  Future<Result<BaseException, LoginModel>> login(
      {required String username, required String password});
  Future<Result<BaseException, SignupModel>> signUp(
      {required String name, required String email, required String password});
}
