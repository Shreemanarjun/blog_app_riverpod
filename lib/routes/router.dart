import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/features/home/presentation/home_view.dart';
import 'package:blog_app_riverpod/features/login/presentation/login_view.dart';
import 'package:blog_app_riverpod/features/signup/presentation/signup_view.dart';
import 'package:blog_app_riverpod/routes/guards/login_guard.dart';
import 'package:blog_app_riverpod/routes/guards/token_guard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: 'login',
      name: 'loginRouter',
      page: LoginView,
      guards: [LoginGuard],
      initial: true,
      deferredLoading: true,
    ),
    AutoRoute(
      path: 'signup',
      name: 'signupRouter',
      page: SignupView,
      deferredLoading: true,
    ),
    AutoRoute(
      path: 'home',
      name: 'HomeRouter',
      page: HomeView,
      guards: [TokenGuard],
      deferredLoading: true,
    ),
  ],
)
class $AppRouter {}
