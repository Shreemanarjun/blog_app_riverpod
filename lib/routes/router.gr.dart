// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:blog_app_riverpod/features/home/presentation/home_view.dart'
    deferred as _i1;
import 'package:blog_app_riverpod/features/login/presentation/login_view.dart'
    deferred as _i3;
import 'package:blog_app_riverpod/features/signup/presentation/signup_view.dart'
    deferred as _i2;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRouter.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.HomeView(),
        ),
      );
    },
    SignupRouter.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.SignupView(),
        ),
      );
    },
    LoginRouter.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.LoginView(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeView]
class HomeRouter extends _i4.PageRouteInfo<void> {
  const HomeRouter({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouter';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SignupView]
class SignupRouter extends _i4.PageRouteInfo<void> {
  const SignupRouter({List<_i4.PageRouteInfo>? children})
      : super(
          SignupRouter.name,
          initialChildren: children,
        );

  static const String name = 'SignupRouter';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class LoginRouter extends _i4.PageRouteInfo<void> {
  const LoginRouter({List<_i4.PageRouteInfo>? children})
      : super(
          LoginRouter.name,
          initialChildren: children,
        );

  static const String name = 'LoginRouter';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
