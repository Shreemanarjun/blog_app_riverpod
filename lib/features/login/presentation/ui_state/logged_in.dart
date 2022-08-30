import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class LoggedInView extends StatelessWidget {
  final String username;
  const LoggedInView({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Flexible(
        child: Lottie.asset(
          'assets/animations/success.json',
          fit: BoxFit.scaleDown,
          height: context.screenHeight * 0.5,
          width: context.screenWidth * 0.5,

          alignment: Alignment.center,
        ).p8().box.color(Colors.white).make(),
      ),
      [
        "Successfully Logged In as $username".text.xl2.make(),
        30.heightBox,
        "Going to homepage....".text.make(),
      ].vStack()
    ]
        .vStack(
            crossAlignment: CrossAxisAlignment.stretch,
            alignment: MainAxisAlignment.center)
        .scrollVertical();
  }
}
