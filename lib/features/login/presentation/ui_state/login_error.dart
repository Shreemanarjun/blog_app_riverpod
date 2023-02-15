import 'package:blog_app_riverpod/features/login/controller/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginErrorView extends StatelessWidget {
  final String message;
  final String details;
  const LoginErrorView({Key? key, required this.message, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            child: Lottie.asset(
          'assets/animations/login_error.json',
          fit: BoxFit.contain,
          height: context.screenHeight,
          width: context.screenWidth,
          alignment: Alignment.center,
          filterQuality: FilterQuality.low,
          frameRate: FrameRate.max,
          addRepaintBoundary: true,
          options: LottieOptions(enableMergePaths: true),
        ).objectCenter()),
        "Error".text.xl.bold.purple600.makeCentered(),
        20.heightBox,
        "$message ".text.makeCentered(),
        "$details...".text.makeCentered(),
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
                ref
                    .read(myloginNotifierProvider.notifier)
                    .changeStatusToInitial();
              },
              child: "Relogin".text.make(),
            );
          },
        ),
        const Spacer(),
      ],
    ).p16();
  }
}
