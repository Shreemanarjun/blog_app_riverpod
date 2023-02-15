// import 'package:blog_app_riverpod/features/login/controller/notifier/auth_notifier.dart';
// import 'package:blog_app_riverpod/shared/riverpod/auth_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class Listener extends Mock {
//   void call(Object? previous, Object value);
// }

// void main() {
//   group('auth test', () {
//     test("try login and check whether login status is changed or not",
//         () async {
//       final container = ProviderContainer();
//       addTearDown(container.dispose);
//       final listener = Listener();
//       container.listen(authProvider.notifier, listener, fireImmediately: true);
//       verifyNever(listener(null, Null)).called(0);
//       final authnotifier = container.read(authProvider.notifier);
//       authnotifier.login();
//       expect(authnotifier,
//           isA<AuthNotifier>().having((s) => s.isLoggedIn, 'isLoggedIn', true));
//       verify(listener(null, authnotifier)).called(1);
//       verifyNoMoreInteractions(listener);
//     });
//   });
//   test(
//       "try login , then logout and check whether login status is changed or not",
//       () async {
//     final container = ProviderContainer();
//     addTearDown(container.dispose);
//     final listener = Listener();
//     container.listen(authProvider.notifier, listener, fireImmediately: true);
//     verifyNever(listener(null, Null)).called(0);
//     final authnotifier = container.read(authProvider.notifier);
//     authnotifier.login();
//     expect(authnotifier,
//         isA<AuthNotifier>().having((s) => s.isLoggedIn, 'isLoggedIn', true));
//     authnotifier.logout();
//     expect(authnotifier,
//         isA<AuthNotifier>().having((s) => s.isLoggedIn, 'isLoggedIn', false));
//     verify(listener(null, authnotifier)).called(lessThan(2));
//     verifyNoMoreInteractions(listener);
//   });
// }
