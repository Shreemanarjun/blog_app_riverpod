
import 'package:blog_app_riverpod/data/models/token_model.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

class Listener extends Mock {
  void call(Object? previous, Object value);
}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Test DB Service', () {
    setUp(() async {
      await setUpTestHive();
    });
    tearDown(() async {
      await tearDownTestHive();
    });
    test("read login model should null at initial", () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(dbServiceProvider, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final db = container.read(dbServiceProvider);
      var testloginmodel = await db.getTokenModel();
      expect(testloginmodel, null);
      verify(listener(null, db)).called(1);
      verifyNoMoreInteractions(listener);
    });

    test(
        "read login model should return a loginmode instance after saving a instance",
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(dbServiceProvider, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final db = container.read(dbServiceProvider);
      await db.saveTokenModel(
          tokenModel: TokenModel(accessToken: 'token', refreshToken: 'auth'));
      var testloginmodel = await db.getTokenModel();
      expect(
          testloginmodel,
          isA<TokenModel>()
              .having((s) => s.accessToken, 'access token', 'token')
              .having((s) => s.refreshToken, 'token type', 'auth'));
      verify(listener(null, db)).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
