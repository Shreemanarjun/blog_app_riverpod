class BaseException implements Exception {
  final String message;
  BaseException({required this.message});
}

class UnauthorizedException extends BaseException {
  UnauthorizedException({super.message = "Unknown Error"});
}
