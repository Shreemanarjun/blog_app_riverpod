import 'package:blog_app_riverpod/features/add_blog/presentation/ui_state/blog_adding_view.dart';
import 'package:blog_app_riverpod/features/add_blog/presentation/ui_state/blog_intital_view.dart';
import 'package:blog_app_riverpod/features/add_blog/controller/add_blog_provider.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class AddBlogView extends ConsumerStatefulWidget {
  const AddBlogView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends ConsumerState<AddBlogView> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  void addBlogListner(AddBlogState? prev, AddBlogState next) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (prev is BlogAdded && next is BlogInitial) {
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
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddBlogState>(addBlogProvider, addBlogListner);
    final addblogstate = ref.watch(addBlogProvider);
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: "Add a new blog".text.lg.semiBold.make(),
        ),
        body: addblogstate
            .map(
              blogInitial: (s) => BlogInitialView(formkey: formKey),
              blogAdding: (p0) => const BlogAddingView(isAdded: false),
              blogAdded: (p0) => const BlogAddingView(isAdded: true),
              blogAddError: (p0) => BlogInitialView(formkey: formKey),
              blogError: (p0) => BlogInitialView(formkey: formKey),
              blogUnauthorizedError: (p0) => BlogInitialView(formkey: formKey),
            )
            .safeArea());
  }
}
