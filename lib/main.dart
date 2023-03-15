import 'dart:async';

import 'package:blog_app_riverpod/app.dart';
import 'package:blog_app_riverpod/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

final talker = TalkerFlutter.init(
  /// like Crashlytics or Sentry observer
  observers: [],
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: true,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: null,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),
);

Future<void> main() async {
  /// A dummy app for flutter to initialize first loading app
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: <Widget>[
            Image.asset('assets/ic_launcher/ic_launcher_foreground.png'),
            const CircularProgressIndicator(),
          ].vStack().centered().safeArea(),
        ),
      ),
    ),
  );

  ///Will use widgets binding to show native splash until all async work done.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///Initialize Hive DB
  await Hive.initFlutter();

  /// If platform is android, apply the highest display refresh rate available on device
  await platform.when(
    android: (() async => await FlutterDisplayMode.setHighRefreshRate()),
  );

  /// Run the real app
  runZonedGuarded(
    () => runApp(
      /// This provider store all the state of descending providers used.
      ProviderScope(
        observers: [
          /// observer for all changes to providers of this providerscope
          MyProviderObserver(),
        ],
        child: const MyApp(),
      ),
    ),
    (Object error, StackTrace stack) {
      talker.handle(error, stack, 'Uncaught app exception');
    },
  );
}
