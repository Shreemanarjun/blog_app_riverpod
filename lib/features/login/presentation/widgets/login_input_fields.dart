import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginInputFields extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginInputFields({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  @override
  Widget build(BuildContext context) {
    return [
      Lottie.asset(
        'assets/animations/login.json',
        filterQuality: FilterQuality.low,
        frameRate: FrameRate.max,
        addRepaintBoundary: true,
        options: LottieOptions(enableMergePaths: true),
        alignment: Alignment.center,
      ).box.height(context.screenHeight * 0.25).make(),
      (context.screenHeight * 0.05).heightBox,
      "Login".text.xl3.bold.cyan600.make().objectCenterLeft(),
      20.heightBox,
      FormBuilderTextField(
        name: 'username',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          hintText: "Enter Username",
          labelText: "Username",
          border: UnderlineInputBorder(),
          prefixIcon: Icon(
            Icons.alternate_email_outlined,
            color: Vx.cyan700,
          ),
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
          ],
        ),
      ).centered(),
      20.heightBox,
      FormBuilderTextField(
        name: 'password',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          hintText: "Enter Password",
          labelText: "Password",
          border: UnderlineInputBorder(),
          prefixIcon: Icon(
            Icons.key_outlined,
            color: Vx.cyan700,
          ),
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
          ],
        ),
      ).centered(),
      30.heightBox,
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              20,
            ))),
        onPressed: widget.onLogin,
        child: "Login".text.make(),
      ),
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
              ref.read(autorouterProvider).navigate(const SignupRouter());
            },
            child: "New here ? Sign up".text.make(),
          );
        },
      ),
    ]
        .vStack(
          crossAlignment: CrossAxisAlignment.stretch,
        )
        .p16()
        .scrollVertical();
  }
}
