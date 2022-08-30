import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeInitialView extends StatelessWidget {
  const HomeInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      "No Blogs.".text.xl.makeCentered(),
    ].vStack().centered();
  }
}
