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
    'login screen test',
    config: patrolConfig,
    nativeAutomation: false,
    ($) async {
      await Hive.initFlutter();
      // Replace with your own app widget.
      await $.pumpWidgetAndSettle(
        ProviderScope(
          observers: [MyLogger()],
          child: const MyApp(),
        ),
      );
      $.waitUntilExists($('Login'));
    },
  );
}
