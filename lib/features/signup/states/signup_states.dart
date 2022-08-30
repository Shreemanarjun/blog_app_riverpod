abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignedUp extends SignupState {
  final String username;
  const SignedUp({
    required this.username,
  });

  @override
  String toString() => 'SignedUp(username: $username)';
}

class SignupError extends SignupState {
  final String? message;
  SignupError({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class NoInternetError extends SignupState {
  const NoInternetError();
}

extension SignupStateUnion on SignupState {
  T map<T>({
    required T Function(SignupInitial) signupInitial,
    required T Function(SignupLoading) signupLoading,
    required T Function(SignedUp) signedUp,
    required T Function(SignupError) signupError,
    required T Function(NoInternetError) noInternetError,
  }) {
    if (this is SignupInitial) {
      return signupInitial(this as SignupInitial);
    }
    if (this is SignupLoading) {
      return signupLoading(this as SignupLoading);
    }
    if (this is SignedUp) {
      return signedUp(this as SignedUp);
    }
    if (this is SignupError) {
      return signupError(this as SignupError);
    }
    if (this is NoInternetError) {
      return noInternetError(this as NoInternetError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}