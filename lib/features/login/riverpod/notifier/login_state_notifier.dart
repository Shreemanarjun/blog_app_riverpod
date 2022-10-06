import 'package:blog_app_riverpod/data/repositories/login/i_login_repository.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:blog_app_riverpod/features/login/state/login_states.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final ILoginRepository loginRepository;
  final IDbService dbService;
  LoginStateNotifier(this.loginRepository, this.dbService)
      : super(const LoginInitial());

  final formKey = GlobalKey<FormBuilderState>();

  Future<void> login() async {
    try {
      final formstate = formKey.currentState;
      if (formstate!.validate()) {
        state = const LoginLoading();
        final username = formstate.fields['username']!.value;
        final password = formstate.fields['password']!.value;
        final result =
            await loginRepository.login(username: username, password: password);
        result.when((error) {
          if (error is ValidationException) {
            state = LoginError(message: error.message, details: "");
            state = const LoginInitial();
          } else if (error.message == 'Invalid Credentials') {
            state = LoginInvalidCredentials(message: error.message);
            state = const LoginInitial();
          } else {
            state = LoginError(message: error.message, details: "");
          }
        }, (loginmodel) async {
          await dbService.saveLoginModel(loginModel: loginmodel);

          state = LoggedIn(username: username);
        });
      }
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
