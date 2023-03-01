import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/routes/guards/login_guard.dart';
import 'package:blog_app_riverpod/routes/guards/token_guard.dart';
import 'package:blog_app_riverpod/routes/router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: LoginRouter.page,
      guards: [LoginGuard()],
    ),
    AutoRoute(
      path: 'signup',
      page: SignupRouter.page,
    ),
    AutoRoute(
      path: 'home',
      page: HomeRouter.page,
      guards: [TokenGuard()],
    ),
  ];
}
