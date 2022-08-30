import 'package:blog_app_riverpod/features/login/presentation/widgets/loader_animation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginLoadingView extends StatelessWidget {
  const LoginLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        40.heightBox,
        Flexible(child: const LoaderAnimation().objectCenter()),
        "Logging you in...".text.xl.bold.purple600.makeCentered(),
        const Spacer(),
      ],
    );
  }
}
