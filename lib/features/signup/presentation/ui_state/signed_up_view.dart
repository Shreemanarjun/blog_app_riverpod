import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          height: context.screenHeight * 0.7,
          width: context.screenWidth,
          alignment: Alignment.center,
        ).p8().box.color(Colors.white).make(),
      ),
      "Successfully Signed up".text.xl2.make(),
      30.heightBox,
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              20,
            ))),
        onPressed: () {
          context.go('/login');
        },
        child: "Login Now".text.make(),
      ),
      30.heightBox,
    ].vStack();
  }
}
