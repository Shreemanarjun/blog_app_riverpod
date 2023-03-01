import 'package:blog_app_riverpod/data/models/token_model.dart';
import 'package:blog_app_riverpod/data/provider/login/i_login_provider.dart';
import 'package:blog_app_riverpod/data/provider/login/login_api_pod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class Listener extends Mock {
  void call(Object? previous, Object value);
}

class FakeLoginProvider extends ILoginProvider {
  @override
  Future<Response> loginUser(
      {required String username, required String password}) async {
    return Response(
      requestOptions: RequestOptions(path: '/login'),
      statusCode: 200,
      data: TokenModel(accessToken: 'access', refreshToken: 'token').toMap(),
    );
  }

  @override
  Future<Response> signUpUser(
      {required String username, required String password}) async {
    return Response(
      requestOptions: RequestOptions(path: '/signup'),
      statusCode: 200,
      data: {"message": "Successfully Signed Up"},
    );
  }
}

void main() {
  group('login provider', () {
    test("check login", () async {
      final container = ProviderContainer(
          overrides: [myloginProvider.overrideWithValue(FakeLoginProvider())]);
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(myloginProvider, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final loginprovider = container.read(myloginProvider);
      expect(
        await loginprovider.loginUser(username: 'name', password: 'password'),
        isA<Response>()
            .having((s) => s.requestOptions.path, 'path', '/login')
            .having(
              (s) => s.data,
              'data',
              TokenModel(accessToken: 'access', refreshToken: 'token').toMap(),
            ),
      );
      verify(listener(null, loginprovider)).called(1);
      verifyNoMoreInteractions(listener);
    });
    test("check signup", () async {
      final container = ProviderContainer(
          overrides: [myloginProvider.overrideWithValue(FakeLoginProvider())]);
      addTearDown(container.dispose);
      final listener = Listener();
      container.listen(myloginProvider, listener, fireImmediately: true);
      verifyNever(listener(null, Null)).called(0);
      final loginprovider = container.read(myloginProvider);
      expect(
        await loginprovider.signUpUser(
          username: 'name',
          password: 'password',
        ),
        isA<Response>()
            .having((s) => s.requestOptions.path, 'path', '/signup')
            .having(
          (s) => s.data,
          'data',
          {"message": "Successfully Signed Up"},
        ),
      );
      verify(listener(null, loginprovider)).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
