import 'package:blog_app_riverpod/data/provider/login/login_api_pod.dart';
import 'package:blog_app_riverpod/data/repositories/login/login_repository.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myloginRepository = Provider.autoDispose(
  (ref) {
    final loginprovider = ref.watch(myloginProvider);
    return LoginRepository(
        loginProvider: loginprovider, dbService: ref.watch(dbServiceProvider));
  },
);
