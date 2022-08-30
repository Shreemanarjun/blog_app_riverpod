import 'package:blog_app_riverpod/features/login/presentation/widgets/login_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginInitialView extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const LoginInitialView({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        autoFocusOnValidationFailure: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: const LoginInputFields());
  }
}
