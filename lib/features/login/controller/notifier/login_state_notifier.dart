import 'package:blog_app_riverpod/data/repositories/login/login_repo_pod.dart';
import 'package:blog_app_riverpod/features/login/state/login_states.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateNotifier extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return const LoginInitial();
  }

  Future<void> login(
      {required String username, required String password}) async {
    try {
      state = const LoginLoading();
      final result = await ref
          .watch(myloginRepository)
          .login(username: username, password: password);
      result.when((error) {
        if (error.message == 'Invalid username or password') {
          state = LoginInvalidCredentials(message: error.message);
          state = const LoginInitial();
        } else {
          state = LoginError(message: error.message, details: "");
        }
      }, (tokenmodel) async {
        await ref
            .watch(dbServiceProvider)
            .saveTokenModel(tokenModel: tokenmodel);

        state = LoggedIn(username: username);
      });
    } on NoInternetException {
      state = LoginNoInternetError();
    } on DioError catch (e) {
      state = LoginError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = LoginError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }

  void changeStatusToInitial() {
    state = const LoginInitial();
  }
}
