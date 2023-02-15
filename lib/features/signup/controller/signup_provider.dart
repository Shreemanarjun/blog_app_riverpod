import 'package:blog_app_riverpod/data/repositories/login/login_repo_pod.dart';


import 'package:blog_app_riverpod/features/signup/controller/notifier/sign_up_state_notifier.dart';
import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mysignupNotifierProvider =
    StateNotifierProvider.autoDispose<SignupStateNotifier, SignupState>(
  (ref) => SignupStateNotifier(loginRepository: ref.watch(myloginRepository)),
);
