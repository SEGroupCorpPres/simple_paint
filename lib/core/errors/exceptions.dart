import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final dynamic code;

  const AppException(this.message, [this.code]);
}

class BadRequestException extends AppException {
  const BadRequestException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ConflictException extends AppException {
  const ConflictException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class InternalServerErrorException extends AppException {
  const InternalServerErrorException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class NetworkException extends AppException {
  const NetworkException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CacheException extends AppException {
  const CacheException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ValidationException extends AppException {
  const ValidationException(super.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(String message) : super(message, 401);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ForbiddenException extends AppException {
  const ForbiddenException(String message) : super(message, 403);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class NotFoundException extends AppException {
  const NotFoundException(String message) : super(message, 404);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerException extends AppException {
  const ServerException(super.message, super.code);

  @override
  List<dynamic> get props => [message, code];
}
