import 'package:blog_app_riverpod/data/repositories/login/login_repo_pod.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:blog_app_riverpod/features/login/controller/notifier/login_state_notifier.dart';
import 'package:blog_app_riverpod/features/login/state/login_states.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';





final myloginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginState>(
  (ref) {
    final dbservice = ref.watch(dbServiceProvider);
    return LoginStateNotifier(ref.watch(myloginRepository), dbservice);
  },
);
