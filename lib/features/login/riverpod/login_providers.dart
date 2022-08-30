import 'package:blog_app_riverpod/data/provider/login/i_login_provider.dart';
import 'package:blog_app_riverpod/data/provider/login/login_provider.dart';
import 'package:blog_app_riverpod/data/repositories/login/login_repository.dart';
import 'package:blog_app_riverpod/shared/riverpod/db_service_provider.dart';
import 'package:blog_app_riverpod/features/login/riverpod/notifier/login_state_notifier.dart';
import 'package:blog_app_riverpod/features/login/state/login_states.dart';

import 'package:blog_app_riverpod/shared/riverpod/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myloginProvider = Provider.autoDispose<ILoginProvider>((ref) =>
    LoginProvider(
        dbService: ref.read(dbServiceProvider), dio: ref.read(dioProvider)));

final myloginRepository = Provider.autoDispose(
  (ref) {
    final loginprovider = ref.read(myloginProvider);
    return LoginRepository(loginProvider: loginprovider);
  },
);

final myloginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginState>(
  (ref) {
    final dbservice = ref.read(dbServiceProvider);
    return LoginStateNotifier(ref.read(myloginRepository), dbservice);
  },
);
