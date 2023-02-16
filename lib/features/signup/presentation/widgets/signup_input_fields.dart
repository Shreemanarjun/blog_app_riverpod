import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupInputFields extends StatelessWidget {
  final void Function() onSignup;
  const SignupInputFields({Key? key, required this.onSignup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'username',
          decoration: const InputDecoration(
              hintText: "Enter Username",
              labelText: "Username",
              border: UnderlineInputBorder(),
              prefixIcon: Icon(
                Icons.person_outline_outlined,
                color: Vx.cyan700,
              )),
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ).centered(),
        20.heightBox,
        FormBuilderTextField(
          name: 'password',
          decoration: const InputDecoration(
            hintText: "Enter Password",
            labelText: "Password",
            border: UnderlineInputBorder(),
            prefixIcon: Icon(
              Icons.key_outlined,
              color: Vx.cyan700,
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
        ).centered(),
        30.heightBox,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                20,
              ))),
          onPressed: onSignup,
          child: "Signup".text.make(),
        )
      ],
    );
  }
}
