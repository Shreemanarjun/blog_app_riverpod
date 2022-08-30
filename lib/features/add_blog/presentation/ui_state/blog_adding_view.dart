import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogAddingView extends StatefulWidget {
  final bool isAdded;
  const BlogAddingView({Key? key, required this.isAdded}) : super(key: key);

  @override
  State<BlogAddingView> createState() => _BlogAddingViewState();
}

class _BlogAddingViewState extends State<BlogAddingView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  void animationListerner() {
    if (!widget.isAdded) {
      if (animationController.value > 0.5) {
        animationController.value = 0.24;
        animationController.reverse();
      } else {
        animationController.forward();
      }
    } else {
      if (animationController.value < 0.5) {
        animationController.value = 1.0;
        animationController.reverse();
      } else {
        animationController.forward();
      }
    }
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.addListener(animationListerner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Lottie.asset(
            "assets/animations/add_success.json",
            controller: animationController,
            repeat: false,
            fit: BoxFit.scaleDown,
            height: context.screenHeight * 0.5,
            width: context.screenWidth * 0.5,
            filterQuality: FilterQuality.medium,
            alignment: Alignment.center,
            onLoaded: (c) {
              animationController
                ..duration = c.duration
                ..forward();
            },
          ).centered(),
        ),
      ],
    ).p8().box.height(context.screenHeight * 0.5).make().scrollVertical();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeListener(animationListerner);
    super.dispose();
  }
}
