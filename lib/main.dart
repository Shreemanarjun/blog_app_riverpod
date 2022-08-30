import 'package:blog_app_riverpod/app.dart';
import 'package:blog_app_riverpod/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await platform.when(
      android: (() async => await FlutterDisplayMode.setHighRefreshRate()));
  runApp(
    ProviderScope(
      observers: [MyLogger()],
      child: const MyApp(),
    ),
  );
}