import 'package:blog_app_riverpod/features/login/presentation/ui_state/logged_in.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_error.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_initial.dart';
import 'package:blog_app_riverpod/features/login/presentation/ui_state/login_loading.dart';

import 'package:blog_app_riverpod/features/login/controller/login_providers.dart';

import 'package:blog_app_riverpod/features/login/state/login_states.dart';
import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  void loginListener(LoginState? previous, LoginState next, WidgetRef ref,
      BuildContext context) {
    if (next is LoggedIn) {
      Future.delayed(const Duration(seconds: 2),
          () {
            return ref.read(autorouterProvider).replaceAll([const HomeRouter()]);
          });
    } else if (previous is LoginInvalidCredentials && next is LoginInitial) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: "Invalid Email or Password !".text.amber600.make()));
    } else if (next is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              "Error occurred due to ${next.message}".text.amber600.make()));
    } else if (next is LoginNoInternetError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: "No internet. ❌.Please reconnect to continue"
              .text
              .amber600
              .make()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final loginstate = ref.watch(myloginNotifierProvider);

            ref.listen<LoginState>(
                myloginNotifierProvider,
                (previous, next) =>
                    loginListener(previous, next, ref, context));

            return loginstate.map(
              loginInitial: (state) => LoginInitialView(
                  formKey: ref.read(myloginNotifierProvider.notifier).formKey),
              loginLoading: (state) => const LoginLoadingView(),
              loggedIn: (state) => LoggedInView(username: state.username),
              loginError: (state) => LoginErrorView(
                  message: state.message, details: state.details ?? ""),
              loginInvalidCredentials: (p0) => LoginInitialView(
                  formKey: ref.read(myloginNotifierProvider.notifier).formKey),
              loginNoInternetError: (p0) => LoginInitialView(
                  formKey: ref.read(myloginNotifierProvider.notifier).formKey),
            );
          },
        ),
      ),
    );
  }
}
