import 'package:blog_app_riverpod/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final internetCheckPod =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) {
  talker.debug("Internet checker started");
  final internetchecker = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(
    seconds: 5,
  ));

  return internetchecker.onStatusChange.distinct();
});
