import 'package:auto_route/auto_route.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blog_app_riverpod/features/signup/presentation/ui_state/signed_up_view.dart';
import 'package:blog_app_riverpod/features/signup/presentation/ui_state/signup_initial_view.dart';
import 'package:blog_app_riverpod/features/signup/presentation/ui_state/signup_loading_view.dart';
import 'package:blog_app_riverpod/features/signup/controller/signup_provider.dart';
import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(name: 'signupRouter', deferredLoading: true)
class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  void signupListener(SignupState? previous, SignupState next) {
    if (next is SignupError) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: next.message ?? "Unknown error",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (next is NoInternetError) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text('No Internet'),
          leading: const Icon(Icons.signal_cellular_0_bar),
          backgroundColor: Colors.green,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('DISMISS'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: [
        Consumer(
          builder: (context, ref, child) {
            final signupstate = ref.watch(mysignupNotifierProvider);
            ref.listen<SignupState>(mysignupNotifierProvider,
                (previous, next) => signupListener(previous, next));
            return signupstate.map(
              signupInitial: (s) => const SignupInitialView(),
              signupLoading: (s) => const SignupLoadingView(),
              signedUp: (s) => const SignedUpView().objectCenter(),
              signupError: (s) => const SignupInitialView(),
              noInternetError: (p0) => const SignupInitialView(),
            );
          },
        ),
      ].vStack().p16().scrollVertical().safeArea(),
    );
  }
}
