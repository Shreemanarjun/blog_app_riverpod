import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SignedUpView extends StatelessWidget {
  const SignedUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Flexible(
        child: Lottie.asset(
          'assets/animations/success.json',
          fit: BoxFit.contain,
          height: context.screenHeight * 0.5,
          width: context.screenWidth,
          alignment: Alignment.center,
          filterQuality: FilterQuality.low,
          frameRate: FrameRate.max,
          addRepaintBoundary: true,
          options: LottieOptions(enableMergePaths: true),
        ).p8().box.color(Colors.transparent).make(),
      ),
      "Successfully Signed up".text.xl2.make(),
      30.heightBox,
      Consumer(
        builder: (context, ref, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  20,
                ))),
            onPressed: () {
              ref.read(autorouterProvider).navigate(const LoginRouter());
            },
            child: "Login Now".text.make(),
          );
        },
      ),
      30.heightBox,
    ].vStack();
  }
}
