abstract class HttpException implements Exception {
  final String message;
  final int? statusCode;

  const HttpException(this.message, [this.statusCode]);
}

class NetworkException extends HttpException {
  const NetworkException(super.message, [super.statusCode]);
}

class TimeoutException extends HttpException {
  const TimeoutException(super.message, [super.statusCode]);
}

class ServerException extends HttpException {
  const ServerException(super.message, [super.statusCode]);
}

class UnknownException extends HttpException {
  const UnknownException(super.message, [super.statusCode]);
}
