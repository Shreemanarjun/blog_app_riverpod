import 'package:blog_app_riverpod/features/login/presentation/ui_state/logged_in.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_error.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_initial.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_loading.dart';
import 'package:blog_app_riverpod/shared/riverpod/auth_provider.dart';
import 'package:blog_app_riverpod/features/login/riverpod/login_providers.dart';

import 'package:blog_app_riverpod/features/login/state/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  void loginListener(LoginState? previous, LoginState next, WidgetRef ref,
      BuildContext context) {
    final authprovider = ref.watch(authProvider.notifier);
    if (next is LoggedIn) {
      Future.delayed(const Duration(seconds: 2), () => authprovider.login());
    } else if (previous is LoginInvalidCredentials && next is LoginInitial) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: "Invalid Email or Password !".text.amber600.make()));
    } else if (next is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: "Error occurred due to ${next.message}"
              .text
              .amber600
              .make()));
    } else if (next is LoginNoInternetError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: "No internet. ❌.Please reconnect to continue"
              .text
              .amber600
              .make()));
    }
  }



/// GETx
/// A depneds upon B
/// B dependes upon A
/// We cannot guarentee run time
/// 
/// riverpod
/// compiles -> ready to go
/// 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer(
        builder: (context, ref, child) {
          final loginstate = ref.watch(myloginNotifierProvider);
          final loginnotifier = ref.read(myloginNotifierProvider.notifier);
          ref.listen<LoginState>(myloginNotifierProvider,
              (previous, next) => loginListener(previous, next, ref, context));

          return loginstate.map(
            loginInitial: (state) =>
                LoginInitialView(formKey: loginnotifier.formKey),
            loginLoading: (state) => const LoginLoadingView(),
            loggedIn: (state) => LoggedInView(username: state.username),
            loginError: (state) => LoginErrorView(
                message: state.message, details: state.details ?? ""),
            loginInvalidCredentials: (p0) =>
                LoginInitialView(formKey: loginnotifier.formKey),
            loginNoInternetError: (p0) =>
                LoginInitialView(formKey: loginnotifier.formKey),
          );
        },
      )),
    );
  }
}
