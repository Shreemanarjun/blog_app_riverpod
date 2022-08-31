import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_initial_view.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_updated_view.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_updating_view.dart';
import 'package:blog_app_riverpod/features/update_blog/riverpod/blog_update_provider.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateBlogView extends ConsumerWidget {
  final BlogModel blogModel;
  const UpdateBlogView(this.blogModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<UpdateBlogState>(updateBlogProvider, (previous, next) async {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (previous is BlogUpdated && next is BlogUpdateInitial) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.of(context).maybePop();
          },
        );
      } else if (next is UnAuthorizedError) {
        showUnauthorizedDialog(context, ref);
      }
    });
    final UpdateBlogState updatestate = ref.watch(updateBlogProvider);
    final updateblognotifier = ref.watch(updateBlogProvider.notifier);
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: "Update Blog ${blogModel.id}".text.lg.semiBold.make(),
        ),
        body: updatestate.map(
          blogUpdateInitial: (p0) => BlogUpdateInitialView(
              blogModel: blogModel, formkey: updateblognotifier.formKey),
          blogUpdating: (p0) => const BlogUpdateUpdatingView(),
          blogUpdated: (p0) => const BlogUpdateUpdatedView(),
          blogUpdateError: (p0) => BlogUpdateInitialView(
              blogModel: blogModel, formkey: updateblognotifier.formKey),
          unAuthorizedError: (p0) => BlogUpdateInitialView(
              blogModel: blogModel, formkey: updateblognotifier.formKey),
          blogGError: (p0) => BlogUpdateInitialView(
              blogModel: blogModel, formkey: updateblognotifier.formKey),
        ));
  }
}
