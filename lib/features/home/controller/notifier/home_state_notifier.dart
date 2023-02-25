import 'dart:async';

import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:blog_app_riverpod/shared/riverpod_ext/cache_extensions.dart';
import 'package:blog_app_riverpod/shared/riverpod_ext/cancel_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomeStateNotifier extends AutoDisposeAsyncNotifier<HomeState> {
  final talker = Talker();
  @override
  FutureOr<HomeState> build() {
    getAllBlogs();
    return future;
  }

  Future<void> getAllBlogs() async {
    state = await AsyncValue.guard(() async {
      /// caches for 3 seconds (it's a default duration for this example)
      final link = ref.cacheFor();

      /// creates a cancel token with auto cancel option
      final token = ref.cancelToken();
      state = AsyncData(HomeLoading(getCurrentBlogs()));
      final result =
          await ref.watch(blogrepository).getAllBlogs(cancelToken: token);
      return result.when((error) {
        if (error is UnauthorizedException) {
          return HomeUnauthorized();
        } else {
          if (error.message == "user cancelled request") {
            link.close();
          }
          return HomeError(message: error.message, details: "");
        }
      }, (blogs) {
        return HomeLoaded(blogs);
      });
    });
  }

  Future<void> refreshBlogs() async {
    talker.log("called refresh all blogs");
    final currentblogs = getCurrentBlogs();
    state = AsyncData(HomeRefreshing(currentblogs));
    state = await AsyncValue.guard(() async {
      /// caches for 3 seconds (it's a default duration for this example)
      final link = ref.cacheFor();

      /// creates a cancel token with auto cancel option
      final token = ref.cancelToken();
      final result =
          await ref.watch(blogrepository).getAllBlogs(cancelToken: token);
      return result.when((error) {
        if (error is UnauthorizedException) {
          return HomeUnauthorized();
        } else {
          if (error.message == "user cancelled request") {
            link.close();
          }
          return (HomeRefreshError(currentblogs));
        }
      }, (blogs) {
        if (blogs != currentblogs) {
          return HomeLoaded(blogs);
        } else {
          return HomeLoaded(blogs);
        }
      });
    });
  }

  Future<void> deleteBlog({required String id}) async {
    final currentblogs = getCurrentBlogs();
    state = AsyncData(HomeBlogDeleting(currentblogs));
    state = await AsyncValue.guard(() async {
      final result = await ref.watch(blogrepository).deleteBlogByID(id: id);
      return result.when((error) {
        if (error is UnauthorizedException) {
          return HomeUnauthorized();
        } else {
          return HomeRefreshError(currentblogs);
        }
      }, (isDeleted) async {
        refreshBlogs();
        return HomeBlogDeleted(currentblogs);
      });
    });
  }

  BlogsModel getCurrentBlogs() {
    if (state is AsyncData) {
      //get all current blogs
      final currentblogs = (state.value)?.blogmodel ?? BlogsModel(blogs: []);
      return currentblogs;
    }
    return BlogsModel(blogs: []);
  }
}
