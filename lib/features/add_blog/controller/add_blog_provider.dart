import 'package:blog_app_riverpod/features/add_blog/controller/notifier/blog_add_notifier.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addBlogProvider =
    StateNotifierProvider.autoDispose<BlogAddNotifier, AddBlogState>(
        ((ref) => BlogAddNotifier(ref.watch(blogrepository))));
