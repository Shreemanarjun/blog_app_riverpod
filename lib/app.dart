import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/main.dart';

import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:blog_app_riverpod/shared/helper/hide_keyboard.dart';
import 'package:blog_app_riverpod/shared/widget/no_internet_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    /// Remove  the splash screen when app starts rendering ,real app
    FlutterNativeSplash.remove();

    /// Get the autorouter to be used for navigation
    final approuter = ref.watch(autorouterProvider);

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

      /// Use responsive framework, for make application responsive
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(
          context,

          /// Add internet checker widget, show the real page on active internet connection,
          /// and some animation when internet disconnected
          InternetCheckerWidget(
            child: widget!.onTap(
              () {
                /// Make outside click ,hides the keyboard
                hideKeyboard(context: context);
              },
            ),
          ),
        ),
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),

      /// add autorouter config for navigation
      routerConfig: approuter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(talker),
        ],
      ),
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
