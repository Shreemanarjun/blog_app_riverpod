class BaseException implements Exception {
  final String message;
  BaseException({this.message = "Unknown Error"});
}

class UnauthorizedException extends BaseException {
  UnauthorizedException({super.message});
}
