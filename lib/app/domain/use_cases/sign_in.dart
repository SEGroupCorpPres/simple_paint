import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class SignIn extends UseCaseWithParams<void, SignInParams> {
  SignIn(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) {
   return _authRepository.signIn(email: params.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
