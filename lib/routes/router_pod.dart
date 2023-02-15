import 'package:blog_app_riverpod/routes/guards/login_guard.dart';
import 'package:blog_app_riverpod/routes/guards/token_guard.dart';
import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autorouterProvider = Provider.autoDispose(
  (ref) => AppRouter(
    tokenGuard: TokenGuard(),
    loginGuard: LoginGuard(),
  ),
);
