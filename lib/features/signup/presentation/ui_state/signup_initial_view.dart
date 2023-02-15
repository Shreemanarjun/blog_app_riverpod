import 'package:blog_app_riverpod/features/signup/controller/signup_provider.dart';
import 'package:blog_app_riverpod/features/signup/presentation/widgets/signup_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupInitialView extends ConsumerStatefulWidget {
  const SignupInitialView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignupInitialViewState();
}

class _SignupInitialViewState extends ConsumerState<SignupInitialView> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  void onSignup() {
    if (formKey.currentState!.validate()) {
      final username =
          formKey.currentState!.fields['username']!.value as String;
      final password =
          formKey.currentState!.fields['password']!.value as String;
      ref
          .read(mysignupNotifierProvider.notifier)
          .signup(username: username, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return [
      Flexible(
        child: Lottie.asset(
          'assets/animations/signup.json',
          fit: BoxFit.contain,
          height: context.screenHeight * 0.25,
          width: context.screenWidth,
          alignment: Alignment.center,
          filterQuality: FilterQuality.low,
          frameRate: FrameRate.max,
          addRepaintBoundary: true,
          options: LottieOptions(enableMergePaths: true),
        ).p8().box.color(Colors.transparent).make(),
      ),
      Consumer(builder: (context, ref, child) {
        return FormBuilder(
          key: formKey,
          autoFocusOnValidationFailure: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SignupInputFields(
            onSignup: onSignup,
          ),
        );
      }),
    ]
        .vStack(
          crossAlignment: CrossAxisAlignment.stretch,
        )
        .scrollVertical();
  }
}
