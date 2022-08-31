import 'package:blog_app_riverpod/data/provider/blog_api/blog_api_provider.dart';
import 'package:blog_app_riverpod/data/provider/blog_api/i_blog_api_provider.dart';
import 'package:blog_app_riverpod/data/repositories/blog/blog_repository.dart';
import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/features/add_blog/riverpod/add_blog_provider.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/features/home/riverpod/notifier/home_state_notifier.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/features/update_blog/riverpod/blog_update_provider.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:blog_app_riverpod/shared/riverpod/db_service_provider.dart';
import 'package:blog_app_riverpod/shared/riverpod/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myblogProvider = Provider.autoDispose<IBlogApiProvider>(
  (ref) => BlogApiProvider(
    dbService: ref.read(dbServiceProvider),
    dio: ref.read(dioProvider),
  ),
);

final blogrepository = Provider.autoDispose<IBlogRepository>(
  (ref) => BlogRepository(
    blogApiProvider: ref.read(myblogProvider),
  ),
);

final homeprovider =
    StateNotifierProvider.autoDispose<HomeStateNotifier, HomeState>(((ref) {
  final dbservice = ref.read(dbServiceProvider);
  ref.listen<AddBlogState>(addBlogProvider, (previous, next) {
    if (next is BlogAdded) {
      Future.delayed(const Duration(seconds: 2), () {
        ref.notifier.refreshBlogs();
      });
    }
  });
  ref.listen<UpdateBlogState>(
    updateBlogProvider,
    (previous, next) {
      if (next is BlogUpdated) {
        Future.delayed(const Duration(seconds: 2), () {
          ref.notifier.refreshBlogs();
        });
      }
    },
  );

  return HomeStateNotifier(ref.read(blogrepository), dbservice)..getAllBlogs();
}));
