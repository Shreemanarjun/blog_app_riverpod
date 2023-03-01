import 'package:blog_app_riverpod/features/login/controller/login_providers.dart';
import 'package:blog_app_riverpod/features/login/presentation/widgets/login_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginInitialView extends ConsumerStatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  const LoginInitialView({
    super.key,
    required this.formKey,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginInitialViewState();
}

class _LoginInitialViewState extends ConsumerState<LoginInitialView> {
  void login() {
    if (widget.formKey.currentState!.validate()) {
      final formstate = widget.formKey.currentState!;
      final username = formstate.fields['username']!.value;
      final password = formstate.fields['password']!.value;
      ref
          .read(myloginNotifierProvider.notifier)
          .login(username: username, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: LoginInputFields(onLogin: login),
    );
  }
}
