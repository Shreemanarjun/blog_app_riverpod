import 'package:blog_app_riverpod/data/models/login_model.dart';
import 'package:blog_app_riverpod/data/service/db/db_service.dart';
import 'package:blog_app_riverpod/shared/riverpod/auth_provider.dart';
import 'package:blog_app_riverpod/shared/riverpod/db_service_provider.dart';
import 'package:blog_app_riverpod/features/login/riverpod/notifier/auth_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplasViewState();
}

class _SplasViewState extends ConsumerState<SplashView> {
  Future<void> checkLoggedin(
      DbService dbService, AuthNotifier authNotifier) async {
    Future.delayed(const Duration(seconds: 2), () async {
      final LoginModel? loginModel = await dbService.readLoginModel();
      if (loginModel != null) {
        authNotifier.login();
      } else {
        if (!mounted) {
          return;
        }
        context.go("/login");
      }
    });
  }

  @override
  void initState() {
    final dbservice = ref.read(dbServiceProvider);
    final authprovider = ref.read(authProvider);
    checkLoggedin(dbservice, authprovider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/animations/splash.json',
        fit: BoxFit.fill,
        height: context.screenHeight,
        alignment: Alignment.center,
      ),
    );
  }
}
