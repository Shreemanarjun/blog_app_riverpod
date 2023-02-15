import 'package:blog_app_riverpod/data/repositories/login/i_login_repository.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_app_riverpod/features/signup/states/signup_states.dart';

import 'package:let_log/let_log.dart';

class SignupStateNotifier extends StateNotifier<SignupState> {
  final ILoginRepository loginRepository;
  SignupStateNotifier({
    required this.loginRepository,
  }) : super(const SignupInitial());

  Future<void> signup(
      {required String username, required String password}) async {
    try {
      final result =
          await loginRepository.signUp(name: username, password: password);
      result.when((error) {
        state = SignupError(message: error.message);
        state = const SignupInitial();
      }, (signupmodel) async {
        state = SignedUp(username: signupmodel.name.toString());
      });
    } on NoInternetException {
      state = const NoInternetError();
    } catch (e) {
      Logger.error("catch $e");
      state = SignupError(message: e.toString());
    }
  }

  void changeStatustoInitial() => state = const SignupInitial();
}
