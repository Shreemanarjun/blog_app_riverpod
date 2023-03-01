import 'package:blog_app_riverpod/features/update_blog/controller/notifier/blog_update_notifier.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateBlogProvider =
    NotifierProvider.autoDispose<BlogUpdateNotifier, UpdateBlogState>(
        BlogUpdateNotifier.new);
