import 'package:blog_app_riverpod/features/login/presentation/widgets/loader_animation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupLoadingView extends StatelessWidget {
  const SignupLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      const Flexible(child: LoaderAnimation()),
      "Signing you up...".text.xl.bold.purple600.makeCentered(),
    ].vStack();
  }
}
