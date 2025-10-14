
abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException(this.message, [this.code]);
}

class BadRequestException extends AppException {
  const BadRequestException(super.message);
}

class ConflictException extends AppException {
  const ConflictException(super.message);
}

class InternalServerErrorException extends AppException {
  const InternalServerErrorException(super.message);
}


class NetworkException extends AppException {
  const NetworkException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(String message) : super(message, 401);
}

class ForbiddenException extends AppException {
  const ForbiddenException(String message) : super(message, 403);
}

class NotFoundException extends AppException {
  const NotFoundException(String message) : super(message, 404);
}