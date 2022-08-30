import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  var isLoggedIn = false;

  void login() {
    if (!isLoggedIn) {
      isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    if (isLoggedIn) {
      isLoggedIn = false;
      notifyListeners();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthNotifier && other.isLoggedIn == isLoggedIn;
  }

  @override
  int get hashCode => isLoggedIn.hashCode;

  @override
  String toString() => 'AuthNotifier(isLoggedIn: $isLoggedIn)';
}
