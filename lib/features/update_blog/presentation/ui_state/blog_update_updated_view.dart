import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogUpdateUpdatedView extends StatelessWidget {
  const BlogUpdateUpdatedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Lottie.asset(
            "assets/animations/update_success.json",
            fit: BoxFit.scaleDown,
            height: context.screenHeight * 0.9,
            width: context.screenWidth * 0.5,
            alignment: Alignment.center,
          ).centered(),
        ),
        "Successfully Updated Blog.".text.green800.lg.makeCentered(),
        const Spacer(),
      ],
    ).p8().box.height(context.screenHeight * 0.5).make().scrollVertical();
  }
}
