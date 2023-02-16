import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_log/let_log.dart';

class BlogAddNotifier extends AutoDisposeNotifier<AddBlogState> {
  @override
  AddBlogState build() {
    return const BlogInitial();
  }

  Future<void> addABlog({required String title}) async {
    state = const BlogAdding();
    Logger.log("add called");
    try {
      final result = await ref.watch(blogrepository).createBlog(
            title: title,
          );
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
    } on DioError catch (e) {
      state = BlogError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = BlogError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }
}
