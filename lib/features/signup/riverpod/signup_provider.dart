import 'package:blog_app_riverpod/features/login/riverpod/login_providers.dart';

import 'package:blog_app_riverpod/features/signup/riverpod/notifier/sign_up_state_notifier.dart';
import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mysignupNotifierProvider =
    StateNotifierProvider.autoDispose<SignupStateNotifier, SignupState>(
  (ref) => SignupStateNotifier(loginRepository: ref.read(myloginRepository)),
);
