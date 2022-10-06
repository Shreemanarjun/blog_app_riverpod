import 'package:blog_app_riverpod/data/models/signup_model.dart';
import 'package:blog_app_riverpod/data/models/login_model.dart';
import 'package:blog_app_riverpod/features/login/riverpod/login_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

import '../provider/login_provider_test.dart';

class Listener extends Mock {
  void call(Object? previous, Object value);
}

void main() {
  group('Login Repository', () {
    test("check login", () async {
      final container = ProviderContainer(overrides: [
        myloginProvider.overrideWithValue(FakeLoginProvider()),
      ]);
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(myloginRepository, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final loginrepository = container.read(myloginRepository);
      expect(
        await loginrepository.login(username: 'name', password: 'password'),
        isA<Result>()
            .having(
              (s) => s.isSuccess(),
              "success",
              true,
            )
            .having(
              (s) => s.getSuccess()!.toMap(),
              'data',
              LoginModel(accesstoken: 'access', tokentype: 'token').toMap(),
            ),
      );
      verify(listener(null, loginrepository)).called(1);
      verifyNoMoreInteractions(listener);
    });
    test("check signup", () async {
      final container = ProviderContainer(overrides: [
        myloginProvider.overrideWithValue(FakeLoginProvider()),
      ]);
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(myloginRepository, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final loginrepository = container.read(myloginRepository);
      expect(
        await loginrepository.signUp(
          name: 'name',
          password: 'password',
          email: 'mail@mail.in',
        ),
        isA<Result>()
            .having(
              (s) => s.isSuccess(),
              "success",
              true,
            )
            .having(
              (s) => s.getSuccess()!.toMap(),
              'data',
              SignupModel(
                name: 'name',
                password: 'password',
                email: 'mail@mail.in',
                id: 0,
              ).toMap(),
            ),
      );
      verify(listener(null, loginrepository)).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
