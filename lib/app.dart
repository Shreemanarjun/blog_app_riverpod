import 'package:auto_route/auto_route.dart';

import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:velocity_x/velocity_x.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final approuter = ref.watch(autorouterProvider);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blog App by Riverpod 💙',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          // replace default CupertinoPageTransitionsBuilder with this
          TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(
            context, widget!.onTap(() => hideKeyboard(context: context))),
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      routeInformationParser: approuter.defaultRouteParser(),
      routerDelegate: approuter.delegate(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de', 'DE'),
        Locale('en', 'IN'),
      ],
    );
  }
}
