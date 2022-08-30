import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_log/let_log.dart';

class BlogAddNotifier extends StateNotifier<AddBlogState> {
  final IBlogRepository blogRepository;
  BlogAddNotifier(this.blogRepository) : super(const BlogInitial());
  final formKey = GlobalKey<FormBuilderState>();
  Future<void> addABlog() async {
    Logger.log("add called");

    try {
      if (formKey.currentState!.validate()) {
        state = const BlogAdding();
        final title = formKey.currentState!.fields['title']!.value.toString();
        final body = formKey.currentState!.fields['body']!.value ?? "";
        final result =
            await blogRepository.createBlog(title: title, body: body);

        result.when((error) {
          if (error is UnauthorizedException) {
            state = const BlogUnauthorizedError();
          } else {
            state = BlogError(message: error.message, details: "");
          }
        }, (createblog) async {
          //formKey.currentState?.reset();
          state = const BlogAdded();
          Future.delayed(const Duration(seconds: 2), () {
            state = const BlogInitial();
          });
        });
      }
    } on DioError catch (e) {
      state = BlogError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = BlogError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }
}
