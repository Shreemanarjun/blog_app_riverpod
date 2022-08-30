import 'package:blog_app_riverpod/data/provider/blog_api/blog_api_provider.dart';
import 'package:blog_app_riverpod/data/provider/blog_api/i_blog_api_provider.dart';
import 'package:blog_app_riverpod/data/repositories/blog/blog_repository.dart';
import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/features/add_blog/riverpod/notifier/blog_add_notifier.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/shared/riverpod/db_service_provider.dart';
import 'package:blog_app_riverpod/shared/riverpod/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myblogProvider = Provider.autoDispose<IBlogApiProvider>(
  (ref) => BlogApiProvider(
      dbService: ref.read(dbServiceProvider), dio: ref.read(dioProvider)),
);

final blogrepository = Provider.autoDispose<IBlogRepository>(
  (ref) => BlogRepository(blogApiProvider: ref.read(myblogProvider)),
);

final addBlogProvider =
    StateNotifierProvider.autoDispose<BlogAddNotifier, AddBlogState>(
        ((ref) => BlogAddNotifier(ref.read(blogrepository))));
