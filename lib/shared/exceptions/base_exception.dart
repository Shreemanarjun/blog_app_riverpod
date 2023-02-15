class BaseException implements Exception {
  final String message;
  BaseException({required this.message});
}

class UnauthorizedException extends BaseException {
  UnauthorizedException({required super.message});
}

