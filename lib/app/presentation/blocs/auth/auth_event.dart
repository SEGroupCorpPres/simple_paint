part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInEvent extends AuthEvent {
  const AuthSignInEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  const AuthSignUpEvent({required this.email, required this.password, required this.name});

  final String email;
  final String password;
  final String name;

  @override
  List<Object?> get props => [email, password, name];
}

class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();

  @override
  List<Object?> get props => [];
}

class CheckIfUserIsFirstTimerEvent extends AuthEvent {
  const CheckIfUserIsFirstTimerEvent();
}

class CacheFirstTimerEvent extends AuthEvent {
  const CacheFirstTimerEvent();
}
