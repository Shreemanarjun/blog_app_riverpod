import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      const CircularProgressIndicator(),
      20.heightBox,
      "Loading your blogs...".text.xl.makeCentered(),
    ].vStack().centered();
  }
}
