import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      Flexible(
        child: Lottie.asset(
          'assets/animations/loading_blog.json',
          fit: BoxFit.contain,
          height: context.screenHeight * 0.4,
          width: context.screenWidth * 0.5,
          filterQuality: FilterQuality.low,
          frameRate: FrameRate.max,
          addRepaintBoundary: true,
          options: LottieOptions(enableMergePaths: true),
          alignment: Alignment.center,
        ).p8().box.color(Colors.transparent).make(),
      ),
      "Loading your blogs...".text.xl2.bold.makeCentered(),
    ].vStack().centered();
  }
}
