import 'package:blog_app_riverpod/data/repositories/login/login_repo_pod.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SignupStateNotifier extends AutoDisposeNotifier<SignupState> {
  @override
  SignupState build() {
    return const SignupInitial();
  }

  final talker = Talker();
  Future<void> signup(
      {required String username, required String password}) async {
    try {
      state = const SignupLoading();
      final result = await ref
          .watch(myloginRepository)
          .signUp(name: username, password: password);
      result.when((error) {
        state = SignupError(message: error.message);
        state = const SignupInitial();
      }, (signupmodel) async {
        state = SignedUp(username: signupmodel.name.toString());
      });
    } on NoInternetException {
      state = const NoInternetError();
    } catch (e) {
      talker.error("catch $e");
      state = SignupError(message: e.toString());
    }
  }

  void changeStatustoInitial() => state = const SignupInitial();
}
