// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../features/home/presentation/home_view.dart' deferred as _i3;
import '../features/login/presentation/login_view.dart' deferred as _i1;
import '../features/signup/presentation/signup_view.dart' deferred as _i2;
import 'guards/login_guard.dart' as _i6;
import 'guards/token_guard.dart' as _i7;

class AppRouter extends _i4.RootStackRouter {
  AppRouter({
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    required this.loginGuard,
    required this.tokenGuard,
  }) : super(navigatorKey);

  final _i6.LoginGuard loginGuard;

  final _i7.TokenGuard tokenGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.LoginView(),
        ),
      );
    },
    SignupRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.SignupView(),
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.HomeView(),
        ),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'login',
          fullMatch: true,
        ),
        _i4.RouteConfig(
          LoginRouter.name,
          path: 'login',
          deferredLoading: true,
          guards: [loginGuard],
        ),
        _i4.RouteConfig(
          SignupRouter.name,
          path: 'signup',
          deferredLoading: true,
        ),
        _i4.RouteConfig(
          HomeRouter.name,
          path: 'home',
          deferredLoading: true,
          guards: [tokenGuard],
        ),
      ];
}

/// generated route for
/// [_i1.LoginView]
class LoginRouter extends _i4.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: 'login',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i2.SignupView]
class SignupRouter extends _i4.PageRouteInfo<void> {
  const SignupRouter()
      : super(
          SignupRouter.name,
          path: 'signup',
        );

  static const String name = 'SignupRouter';
}

/// generated route for
/// [_i3.HomeView]
class HomeRouter extends _i4.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: 'home',
        );

  static const String name = 'HomeRouter';
}
