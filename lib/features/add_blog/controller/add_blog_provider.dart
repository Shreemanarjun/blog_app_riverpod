import 'package:blog_app_riverpod/features/add_blog/controller/notifier/blog_add_notifier.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addBlogProvider =
    NotifierProvider.autoDispose<BlogAddNotifier, AddBlogState>(
        BlogAddNotifier.new);
