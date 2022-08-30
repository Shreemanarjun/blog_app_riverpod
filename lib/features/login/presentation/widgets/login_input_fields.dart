import 'package:blog_app_riverpod/features/login/riverpod/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginInputFields extends StatefulWidget {
  const LoginInputFields({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  @override
  Widget build(BuildContext context) {
    return [
      20.heightBox,
      Lottie.asset(
        'assets/animations/login.json',
        filterQuality: FilterQuality.medium,
        alignment: Alignment.center,
      ).box.height(context.screenHeight * 0.25).make(),
      (context.screenHeight * 0.05).heightBox,
      "Login".text.xl3.bold.cyan600.make().objectCenterLeft(),
      20.heightBox,
      FormBuilderTextField(
        name: 'username',
        initialValue: 'ss@ss.in',
        decoration: const InputDecoration(
            hintText: "Enter Email",
            labelText: "Email",
            border: UnderlineInputBorder(),
            prefixIcon: Icon(
              Icons.alternate_email_outlined,
              color: Vx.cyan700,
            )),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]),
      ).centered(),
      20.heightBox,
      FormBuilderTextField(
        name: 'password',
        initialValue: 'ss',
        decoration: const InputDecoration(
          hintText: "Enter Password",
          labelText: "Password",
          border: UnderlineInputBorder(),
          prefixIcon: Icon(
            Icons.key_outlined,
            color: Vx.cyan700,
          ),
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ).centered(),
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
              ref.read(myloginNotifierProvider.notifier).login();
            },
            child: "Login".text.make(),
          );
        },
      ),
      30.heightBox,
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              20,
            ))),
        onPressed: () {
          GoRouter.of(context).push("/signup");
        },
        child: "New here ? Sign up".text.make(),
      ),
    ]
        .vStack(
          crossAlignment: CrossAxisAlignment.stretch,
        )
        .p16()
        .scrollVertical();
  }
}
