import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogUpdateUpdatingView extends StatelessWidget {
  const BlogUpdateUpdatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Lottie.asset(
            "assets/animations/update.json",
            height: context.screenHeight * 0.8,
            width: context.screenWidth * 0.5,
            alignment: Alignment.center,
            filterQuality: FilterQuality.low,
            frameRate: FrameRate.max,
            addRepaintBoundary: true,
            options: LottieOptions(enableMergePaths: true),
          ).centered(),
        ),
        "Updating...".text.green600.lg.makeCentered(),
        const Spacer(),
      ],
    ).p8().box.height(context.screenHeight * 0.5).color(Colors.white).make().scrollVertical();
  }
}
