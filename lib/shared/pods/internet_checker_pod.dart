import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:talker_flutter/talker_flutter.dart';

final internetCheckPod =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) {
  final talker = Talker();
  talker.debug("Internet checker started");
  final internetchecker = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(
    seconds: 5,
  ));

  return internetchecker.onStatusChange.distinct();
});
