import 'dart:async';

import 'package:blog_app_riverpod/app.dart';
import 'package:blog_app_riverpod/init.dart';
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
    settings:  TalkerSettings(
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
  runApp(ProviderScope(child: MaterialApp(
    home: Scaffold(
      body: const CircularProgressIndicator().centered().safeArea(),
    ),
  )));
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await platform.when(
      android: (() async => await FlutterDisplayMode.setHighRefreshRate()));
  await init();

  runZonedGuarded(
    () => runApp(ProviderScope(
      observers: [MyLogger()],
      child: const MyApp(),
    )),
    (Object error, StackTrace stack) {
      talker.handle(error, stack, 'Uncaught app exception');
    },
  );
}
