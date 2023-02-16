import 'package:blog_app_riverpod/features/login/controller/notifier/login_state_notifier.dart';
import 'package:blog_app_riverpod/features/login/state/login_states.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final myloginNotifierProvider =
    NotifierProvider.autoDispose<LoginStateNotifier, LoginState>(
        LoginStateNotifier.new);
