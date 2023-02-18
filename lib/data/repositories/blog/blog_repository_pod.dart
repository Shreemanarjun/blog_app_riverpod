
import 'package:blog_app_riverpod/data/provider/blog_api/blog_api_pod.dart';
import 'package:blog_app_riverpod/data/repositories/blog/blog_repository.dart';
import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogrepository = Provider.autoDispose<IBlogRepository>(
  (ref) => BlogRepository(
    blogApiProvider: ref.watch(myblogProvider),
  ),
);
