import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyLogger extends ProviderObserver {
  final talker = Talker();
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    if (newValue is StateController) {
      final newv = newValue.state;
      final perviousv = (previousValue as StateController).state;
      talker.debug('Provider is: '
          '${provider.name ?? provider.runtimeType} \n'
          'previous value: $perviousv \n'
          'new value: $newv');
    } else if (newValue is AsyncValue) {
      final newv = newValue.value;
      final perviousv = (previousValue as AsyncValue).value;
      talker.debug('Provider is: '
          '${provider.name ?? provider.runtimeType} \n'
          'previous value: $perviousv \n'
          'new value: $newv');
    } else {
      talker.debug('Provider is: '
          '${provider.name ?? provider.runtimeType} \n'
          'previous value: ${previousValue.toString()}\n'
          'new value: ${newValue.toString()}');
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
