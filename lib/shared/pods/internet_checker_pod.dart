import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:let_log/let_log.dart';

final internetCheckPod =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) {
  Logger.debug("Internet checker started");
  final internetchecker = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(
    seconds: 5,
  ));

  return internetchecker.onStatusChange.distinct();
});
