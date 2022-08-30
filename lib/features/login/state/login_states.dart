abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoggedIn extends LoginState {
  final String username;
  const LoggedIn({required this.username});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoggedIn && other.username == username;
  }

  @override
  int get hashCode => username.hashCode;

  @override
  String toString() => 'LoggedIn(username: $username)';
}

class LoginInvalidCredentials extends LoginState {
  final String? message;
  const LoginInvalidCredentials({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginInvalidCredentials && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'LoginInvalidCredentials(message: $message)';
}



class LoginError extends LoginState {
  final String message;
  final String? details;
  const LoginError({required this.message, required this.details});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginError &&
        other.message == message &&
        other.details == details;
  }

  @override
  int get hashCode => message.hashCode ^ details.hashCode;

  @override
  String toString() => 'LoginError(message: $message, details: $details)';
}

class LoginNoInternetError extends LoginState{}

extension LoginStateUnion on LoginState {
  T map<T>({
    required T Function(LoginInitial) loginInitial,
    required T Function(LoginLoading) loginLoading,
    required T Function(LoggedIn) loggedIn,
    required T Function(LoginInvalidCredentials) loginInvalidCredentials,
    required T Function(LoginError) loginError,
    required T Function(LoginNoInternetError) loginNoInternetError,
  }) {
    if (this is LoginInitial) {
      return loginInitial(this as LoginInitial);
    }
    if (this is LoginLoading) {
      return loginLoading(this as LoginLoading);
    }
    if (this is LoggedIn) {
      return loggedIn(this as LoggedIn);
    }
    if (this is LoginInvalidCredentials) {
      return loginInvalidCredentials(this as LoginInvalidCredentials);
    }
    if (this is LoginError) {
      return loginError(this as LoginError);
    }
    if (this is LoginNoInternetError) {
      return loginNoInternetError(this as LoginNoInternetError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}