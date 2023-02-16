import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_initial_view.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_updated_view.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/ui_state/blog_update_updating_view.dart';
import 'package:blog_app_riverpod/features/update_blog/controller/blog_update_provider.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateBlogView extends ConsumerStatefulWidget {
  final BlogModel blogModel;
  const UpdateBlogView({
    super.key,
    required this.blogModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateBlogViewState();
}

class _UpdateBlogViewState extends ConsumerState<UpdateBlogView> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  void listenUpdateBlog(UpdateBlogState? previous, UpdateBlogState next) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (previous is BlogUpdated && next is BlogUpdateInitial) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (context.mounted) {
            Navigator.of(context).maybePop();
          }
        },
      );
    } else if (next is UnAuthorizedError) {
      showUnauthorizedDialog(context, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UpdateBlogState>(updateBlogProvider, listenUpdateBlog);
    final UpdateBlogState updatestate = ref.watch(updateBlogProvider);

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: "Update Blog ${widget.blogModel.id}".text.lg.semiBold.make(),
        ),
        body: updatestate.map(
          blogUpdateInitial: (p0) => BlogUpdateInitialView(
            blogModel: widget.blogModel,
            formkey: formKey,
          ),
          blogUpdating: (p0) => const BlogUpdateUpdatingView(),
          blogUpdated: (p0) => const BlogUpdateUpdatedView(),
          blogUpdateError: (p0) => BlogUpdateInitialView(
            blogModel: widget.blogModel,
            formkey: formKey,
          ),
          unAuthorizedError: (p0) => BlogUpdateInitialView(
            blogModel: widget.blogModel,
            formkey: formKey,
          ),
          blogGError: (p0) => BlogUpdateInitialView(
            blogModel: widget.blogModel,
            formkey: formKey,
          ),
        ));
  }
}
