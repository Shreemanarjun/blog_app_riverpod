import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/update_blog/controller/blog_update_provider.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogUpdateInitialView extends StatelessWidget {
  final GlobalKey<FormBuilderState> formkey;
  final BlogModel blogModel;
  const BlogUpdateInitialView({
    Key? key,
    required this.formkey,
    required this.blogModel,
  }) : super(key: key);

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
          initialValue: blogModel.title,
          decoration: const InputDecoration(
              labelText: "Title",
              hintText: 'Enter Title Here',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder()),
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
        ),
        20.heightBox,
        30.heightBox,
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () async {
                hideKeyboard(context: context);
                ref
                    .read(updateBlogProvider.notifier)
                    .updateBlog(id: blogModel.id.toString());
              },
              child: "Update".text.isIntrinsic.make(),
            );
          },
        )
      ].vStack().p8(),
    ).scrollVertical();
  }
}
