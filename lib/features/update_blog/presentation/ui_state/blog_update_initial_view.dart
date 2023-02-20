import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/update_blog/controller/blog_update_provider.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogUpdateInitialView extends ConsumerStatefulWidget {
  final GlobalKey<FormBuilderState> formkey;
  final BlogModel blogModel;
  const BlogUpdateInitialView({
    super.key,
    required this.formkey,
    required this.blogModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlogUpdateInitialViewState();
}

class _BlogUpdateInitialViewState extends ConsumerState<BlogUpdateInitialView> {
  void updateBlog() {
    if (widget.formkey.currentState!.validate()) {
      hideKeyboard(context: context);
      final title = widget.formkey.currentState!.fields['title']!.value;
      final description =
          widget.formkey.currentState!.fields['description']!.value;

      ref.read(updateBlogProvider.notifier).updateBlog(
          id: widget.blogModel.id.toString(),
          title: title,
          description: description);
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
          initialValue: widget.blogModel.title,
          decoration: const InputDecoration(
              labelText: "Title",
              hintText: 'Enter Title Here',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder()),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              if (value == widget.blogModel.title) {
                return "Please change something in text to update";
              } else {
                return null;
              }
            }
          ]),
        ),
        20.heightBox,
        FormBuilderTextField(
          name: 'description',
          initialValue: widget.blogModel.description,
          decoration: const InputDecoration(
              labelText: "Description",
              hintText: 'Enter Description Here',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder()),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              if (value == widget.blogModel.description) {
                return "Please change something in text to update";
              } else {
                return null;
              }
            }
          ]),
        ),
        30.heightBox,
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: updateBlog,
              child: "Update".text.isIntrinsic.make(),
            );
          },
        )
      ].vStack().p8(),
    ).scrollVertical();
  }
}
