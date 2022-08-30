import 'package:blog_app_riverpod/data/repositories/login/i_login_repository.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';

import 'package:let_log/let_log.dart';

class SignupStateNotifier extends StateNotifier<SignupState> {
  final ILoginRepository loginRepository;
  SignupStateNotifier({
    required this.loginRepository,
  }) : super(const SignupInitial());
  final formKey = GlobalKey<FormBuilderState>();

  Future<void> signup() async {
    try {
      final formstate = formKey.currentState;
      if (formstate!.validate()) {
        state = const SignupLoading();
        final name = formstate.fields['name']!.value;
        final email = formstate.fields['email']!.value;
        final password = formstate.fields['password']!.value;
        final result = await loginRepository.signUp(
            name: name, email: email, password: password);
        result.when((error) {
          if (error is ValidationException) {
            state = SignupError(message: error.message);
            state = const SignupInitial();
          } else {
            state = SignupError(message: error.message);
            state = const SignupInitial();
          }
        }, (signupmodel) async {
          state = SignedUp(username: signupmodel.name.toString());
        });
      } else {
        Logger.log("invalid form");
      }
    } on NoInternetException {
      state = const NoInternetError();
    } catch (e) {
      Logger.error("catch $e");
      state = SignupError(message: e.toString());
    }
  }

  void changeStatustoInitial() => state = const SignupInitial();
}
