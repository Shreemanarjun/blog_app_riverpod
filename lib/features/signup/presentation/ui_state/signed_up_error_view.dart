import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignedUpErrorView extends StatelessWidget {
  final String error;
  const SignedUpErrorView({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return error.text.make();
  }
}
