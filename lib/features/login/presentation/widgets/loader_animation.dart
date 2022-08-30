import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/loading.json',
      fit: BoxFit.scaleDown,
      height: context.screenHeight * 0.5,
      width: context.screenWidth * 0.5,
      alignment: Alignment.center,
    ).p8().box.color(Colors.white).make();
  }
}
