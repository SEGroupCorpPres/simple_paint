part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSignedInState extends AuthState {
  const AuthSignedInState({required this.user});

  final LocalUser user;

  @override
  List<Object?> get props => [user];
}

class AuthSignedUpState extends AuthState {
  const AuthSignedUpState();
}

class AuthSignedOutState extends AuthState {
  const AuthSignedOutState();
}



class AuthErrorState extends AuthState {
  const AuthErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [super.props];
}
