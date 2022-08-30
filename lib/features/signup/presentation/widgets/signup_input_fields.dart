import 'package:blog_app_riverpod/features/signup/riverpod/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupInputFields extends StatelessWidget {
  const SignupInputFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'name',
          initialValue: 'ss',
          decoration: const InputDecoration(
              hintText: "Enter Name",
              labelText: "Name",
              border: UnderlineInputBorder(),
              prefixIcon: Icon(
                Icons.person_outline_outlined,
                color: Vx.cyan700,
              )),
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ).centered(),
        FormBuilderTextField(
          name: 'email',
          initialValue: 'ss@ss.in',
          decoration: const InputDecoration(
              hintText: "Enter Email",
              labelText: "Email",
              border: UnderlineInputBorder(),
              prefixIcon: Icon(
                Icons.alternate_email_outlined,
                color: Vx.cyan700,
              )),
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email()
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                ref.read(mysignupNotifierProvider.notifier).signup();
              },
              child: "Signup".text.make(),
            );
          },
        ),
      ],
    );
  }
}
