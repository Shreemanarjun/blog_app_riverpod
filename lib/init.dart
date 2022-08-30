import 'package:flutter/foundation.dart';
import 'package:let_log/let_log.dart';

Future<void> init() async {
  configLogger();
}

///Configure the logger
void configLogger() {
  // Logger.enabled = true;
  Logger.enabled = !kReleaseMode;
  Logger.config.maxLimit = 1000000000;
  Logger.config.reverse = false;
  Logger.config.printLog = true;
  Logger.config.printNet = true;

  Logger.config.setPrintNames(
    log: '[😄Log]',
    debug: '[🐛Debug]',
    warn: '[❗Warn]',
    error: '[❌Error]',
    request: '[⬆️Req]',
    response: '[⬇️Res]',
  );

  Logger.config.setTabNames(
    log: '😄',
    debug: '🐛',
    warn: '❗',
    error: '❌',
    request: '⬆️',
    response: '⬇️',
  );
}
