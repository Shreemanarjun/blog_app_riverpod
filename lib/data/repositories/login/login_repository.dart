import 'package:blog_app_riverpod/data/models/login_model.dart';
import 'package:blog_app_riverpod/data/models/signup_model.dart';
import 'package:blog_app_riverpod/data/models/validation_error_model.dart';
import 'package:blog_app_riverpod/data/provider/login/i_login_provider.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';

import 'i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  final ILoginProvider loginProvider;
  LoginRepository({required this.loginProvider});

  @override
  Future<Result<BaseException, LoginModel>> login(
      {required String username, required String password}) async {
    final result =
        await loginProvider.loginUser(username: username, password: password);
    if (result.statusCode == 200) {
      try {
        final loginmodel = LoginModel.fromMap(result.data);
        return Success(loginmodel);
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, SignupModel>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final result = await loginProvider.signUpUser(
        name: name, email: email, password: password);

    if (result.statusCode == 200 || result.statusCode == 201) {
      try {
        final signupModel = SignupModel.fromMap(result.data);
        return Success(signupModel);
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 400) {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }
}
