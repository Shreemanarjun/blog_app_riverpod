import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:let_log/let_log.dart';

class BlogUpdateNotifier extends AutoDisposeNotifier<UpdateBlogState> {
  @override
  UpdateBlogState build() {
    return const BlogUpdateInitial();
  }

  final formKey = GlobalKey<FormBuilderState>();

  void updateBlog({required String id, required String title}) async {
    try {
      state = const BlogUpdating();
      final title = formKey.currentState!.fields['title']!.value.toString();
      Logger.debug(title);
      final result =
          await ref.watch(blogrepository).updateBlogByID(title: title, id: id);

      result.when((error) {
        if (error is UnauthorizedException) {
          state = const UnAuthorizedError();
        } else {
          state = BlogGError(message: error.message, details: "");
        }
      }, (createblog) async {
        //formKey.currentState?.reset();
        state = const BlogUpdated();
        Future.delayed(const Duration(seconds: 2), () {
          state = const BlogUpdateInitial();
        });
      });
    } on DioError catch (e) {
      state = BlogGError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = BlogGError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }
}
