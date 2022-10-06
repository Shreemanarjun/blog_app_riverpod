import 'package:blog_app_riverpod/features/signup/presentation/widgets/signup_input_fields.dart';
import 'package:blog_app_riverpod/features/signup/riverpod/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupInitialView extends StatelessWidget {
  const SignupInitialView({Key? key}) : super(key: key);

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
          key: ref.read(mysignupNotifierProvider.notifier).formKey,
          autoFocusOnValidationFailure: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: const SignupInputFields(),
        );
      }),
    ]
        .vStack(
          crossAlignment: CrossAxisAlignment.stretch,
        )
        .scrollVertical();
  }
}
