import 'package:blog_app_riverpod/features/add_blog/riverpod/add_blog_provider.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogIntitalView extends StatelessWidget {
  final GlobalKey<FormBuilderState> formkey;
  const BlogIntitalView({Key? key, required this.formkey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formkey,
      autoFocusOnValidationFailure: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: [
        20.heightBox,
        FormBuilderTextField(
          name: 'title',
          decoration: const InputDecoration(
              labelText: "Title",
              hintText: 'Enter Title Here',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder()),
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
        ),
        20.heightBox,
        FormBuilderTextField(
          name: 'body',
          maxLines: 5,
          decoration: const InputDecoration(
              labelText: "Body",
              hintText: 'Enter Body',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder()),
        ),
        30.heightBox,
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () async {
                hideKeyboard(context: context);
                await ref.read(addBlogProvider.notifier).addABlog();
              },
              child: "Add".text.isIntrinsic.make(),
            );
          },
        )
      ].vStack().p8(),
    ).scrollVertical();
  }
}
