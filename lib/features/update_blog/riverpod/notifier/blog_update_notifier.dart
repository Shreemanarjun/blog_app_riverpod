import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';

class BlogUpdateNotifier extends StateNotifier<UpdateBlogState> {
  final IBlogRepository blogRepository;
  BlogUpdateNotifier({
    required this.blogRepository,
  }) : super(const BlogUpdateInitial());
  final formKey = GlobalKey<FormBuilderState>();

  void updateBlog({required String id}) async {
    try {
      if (formKey.currentState!.validate()) {
        state = const BlogUpdating();
        final title = formKey.currentState!.fields['title']!.value.toString();
        final body = formKey.currentState!.fields['body']!.value ?? "";
        final result = await blogRepository.updateBlogByID(
            title: title, body: body, id: id);

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
      }
    } on DioError catch (e) {
      state = BlogGError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = BlogGError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }
}
