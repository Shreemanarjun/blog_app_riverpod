// ignore_for_file: avoid_print
import 'package:blog_app_riverpod/app.dart';
import 'package:blog_app_riverpod/observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

// This is an example integration test using Patrol. Use it as a base to
// create your own Patrol-powered test.
//
// To run it, you have to use `patrol drive` instead of `flutter test`.

void main() {
  patrolTest(
    'Test Login',
    config: patrolConfig,
    nativeAutomation: true,
    ($) async {
      await Hive.initFlutter();
      await $.pumpWidgetAndSettle(
        ProviderScope(
          observers: [MyLogger()],
          child: const MyApp(),
        ),
      );

      // await $.native.pressHome();

      // await $.native.pressDoubleRecentApps();

      // await $.native.openNotifications();

      // await $.native.enableWifi();
      // await $.native.disableWifi();
      // await $.native.enableWifi();

      // await $.native.pressBack();

      // expect($('app'), findsOneWidget);
    },
  );
}
