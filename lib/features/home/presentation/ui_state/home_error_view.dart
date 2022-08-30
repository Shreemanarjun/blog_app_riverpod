import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeErrorView extends StatelessWidget {
  final String message;
  final String details;
  const HomeErrorView({Key? key, required this.message, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "$message $details".text.sm.makeCentered();
  }
}
