import 'package:blog_app_riverpod/data/models/signup_model.dart';
import 'package:blog_app_riverpod/data/models/token_model.dart';
import 'package:blog_app_riverpod/data/provider/login/i_login_provider.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';

import 'i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  final ILoginProvider loginProvider;
  final IDbService dbService;
  LoginRepository({
    required this.loginProvider,
    required this.dbService,
  });

  @override
  Future<Result<BaseException, TokenModel>> login(
      {required String username, required String password}) async {
    final result =
        await loginProvider.loginUser(username: username, password: password);
    if (result.statusCode == 200) {
      try {
        final tokenmodel = TokenModel.fromMap(result.data);
        await dbService.saveTokenModel(tokenModel: tokenmodel);
        return Success(tokenmodel);
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else {
      final details = result.data['message'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, SignupModel>> signUp(
      {required String name, required String password}) async {
    final result =
        await loginProvider.signUpUser(username: name, password: password);

    if (result.statusCode == 200 || result.statusCode == 201) {
      try {
        final signupModel = SignupModel.fromMap(result.data);
        return Success(signupModel);
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 400) {
      final details = result.data['message'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    } else {
      final details = result.data['message'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }
}
