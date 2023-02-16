import 'package:blog_app_riverpod/features/add_blog/presentation/ui_state/blog_adding_view.dart';
import 'package:blog_app_riverpod/features/add_blog/presentation/ui_state/blog_intital_view.dart';
import 'package:blog_app_riverpod/features/add_blog/controller/add_blog_provider.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class AddBlogView extends ConsumerWidget {
  const AddBlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final addblogstate = ref.watch(addBlogProvider);

    ref.listen<AddBlogState>(addBlogProvider, (previous, next) async {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (previous is BlogAdded && next is BlogInitial) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            if (context.mounted) {
              Navigator.of(context).maybePop();
            }
          },
        );
      } else if (next is BlogUnauthorizedError) {
        showUnauthorizedDialog(context, ref);
      }
    });
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: "Add a new blog".text.lg.semiBold.make(),
        ),
        body: addblogstate
            .map(
              blogInitial: (s) => BlogIntitalView(
                  formkey: ref.read(addBlogProvider.notifier).formKey),
              blogAdding: (p0) => const BlogAddingView(isAdded: false),
              blogAdded: (p0) => const BlogAddingView(isAdded: true),
              blogAddError: (p0) => BlogIntitalView(
                  formkey: ref.read(addBlogProvider.notifier).formKey),
              blogError: (p0) => BlogIntitalView(
                  formkey: ref.read(addBlogProvider.notifier).formKey),
              blogUnauthorizedError: (p0) => BlogIntitalView(
                  formkey: ref.read(addBlogProvider.notifier).formKey),
            )
            .safeArea());
  }
}
