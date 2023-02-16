import 'package:blog_app_riverpod/features/add_blog/controller/add_blog_provider.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogInitialView extends ConsumerStatefulWidget {
  final GlobalKey<FormBuilderState> formkey;
  const BlogInitialView({
    super.key,
    required this.formkey,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlogInitislViewState();
}

class _BlogInitislViewState extends ConsumerState<BlogInitialView> {
  
  void addBlog() {
    hideKeyboard(context: context);
    if (widget.formkey.currentState!.validate()) {
      final title =
          widget.formkey.currentState!.fields['title']!.value.toString();
      ref.read(addBlogProvider.notifier).addABlog(title: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formkey,
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
        30.heightBox,
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: addBlog,
              child: "Add".text.isIntrinsic.make(),
            );
          },
        )
      ].vStack().p8(),
    ).scrollVertical();
  }
}
