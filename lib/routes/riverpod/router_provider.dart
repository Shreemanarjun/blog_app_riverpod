import 'package:blog_app_riverpod/features/home/presentation/home_view.dart';
import 'package:blog_app_riverpod/features/add_blog/presentation/add_blog_view.dart';
import 'package:blog_app_riverpod/features/login/presentation/login_view.dart';
import 'package:blog_app_riverpod/shared/riverpod/auth_provider.dart';
import 'package:blog_app_riverpod/features/signup/presentation/signup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:let_log/let_log.dart';

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final isloggedIn =
      ref.watch(authProvider.select((value) => value.isLoggedIn));
  final GoRouter router = GoRouter(
    initialLocation: isloggedIn ? "/home" : "/login",
    routes: <GoRoute>[
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
          path: "/home",
          builder: (context, state) => const HomeView(),
          routes: [
            GoRoute(
              path: "addBlog",
              builder: (context, state) => const AddBlogView(),
            ),
          ]),
    ],
    debugLogDiagnostics: true,
    refreshListenable: ref.read(authProvider.notifier),
    redirect: (context, state) async {
      final userloggedin = isloggedIn;
      Logger.log("user loggedin :$userloggedin");
      Logger.log(
          'state location ${state.location} sublocation ${state.subloc}');
      if (state.location == "/login" && !userloggedin) {
        return null;
      } else if (state.location == "/signup" && !userloggedin) {
        return null;
      } else {
        if (userloggedin) {
          if (state.location == "/home") {
            ///check the current location is home or
            return state.location == "/home" ? null : "/home";
          } else if (state.location == "/login") {
            return state.location == "/login" ? null : "/login";
          } else {
            return null;
          }
        }
      }
      return null;
    },
  );
  return router;
});
