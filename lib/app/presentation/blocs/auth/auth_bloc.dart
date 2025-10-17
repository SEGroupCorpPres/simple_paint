import 'package:simple_paint/app/presentation/blocs/blocs.dart';
import 'package:simple_paint/core/core.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required SignIn signIn, required SignUp signUp, required SignOut signOut})
    : _signIn = signIn,
      _signUp = signUp,
      _signOut = signOut,
      super(const AuthInitialState()) {
    on<AuthEvent>(_onAuth);
    on<AuthSignInEvent>(_signInHandler);
    on<AuthSignUpEvent>(_signUpHandler);
    on<AuthSignOutEvent>(_signOutHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;

  Future<void> _onAuth(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());
  }

  Future<void> _signInHandler(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(SignInParams(email: event.email, password: event.password));

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSignedInState(user: user)),
    );
  }

  Future<void> _signUpHandler(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(
      SignUpParams(email: event.email, password: event.password, fullName: ''),
    );
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSignedUpState()),
    );
  }

  Future<void> _signOutHandler(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());
    final result = await _signOut();
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (_) => emit(const AuthSignedOutState()),
    );
  }
}
