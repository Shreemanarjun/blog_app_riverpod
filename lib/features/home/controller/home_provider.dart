import 'package:blog_app_riverpod/data/provider/blog_api/blog_api_provider.dart';
import 'package:blog_app_riverpod/data/provider/blog_api/i_blog_api_provider.dart';
import 'package:blog_app_riverpod/data/repositories/blog/blog_repository.dart';
import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/features/home/controller/notifier/home_state_notifier.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:blog_app_riverpod/shared/dio_client/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myblogProvider = Provider.autoDispose<IBlogApiProvider>(
  (ref) => BlogApiProvider(
    dbService: ref.watch(dbServiceProvider),
    dio: ref.watch(dioProvider),
  ),
);

final blogrepository = Provider.autoDispose<IBlogRepository>(
  (ref) => BlogRepository(
    blogApiProvider: ref.watch(myblogProvider),
  ),
);

final homeprovider = AsyncNotifierProvider.autoDispose<HomeStateNotifier, HomeState>(
    HomeStateNotifier.new);
