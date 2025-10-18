import 'package:simple_paint/app/presentation/blocs/blocs.dart';
import 'package:simple_paint/core/core.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required SignOut signOut,
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  }) : _signIn = signIn,
       _signUp = signUp,
       _signOut = signOut,
       _cacheFirstTimer = cacheFirstTimer,
       _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
       super(const AuthInitialState()) {
    on<AuthSignInEvent>(_signInHandler);
    on<AuthSignUpEvent>(_signUpHandler);
    on<AuthSignOutEvent>(_signOutHandler);
    on<CacheFirstTimerEvent>(_cacheFirstTimerCheck);
    on<CheckIfUserIsFirstTimerEvent>(_checkIfUserIsFirstTimerCheck);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> _signInHandler(AuthSignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(SignInParams(email: event.email, password: event.password));
    emit(const AuthLoadingState());

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSignedInState(user: user)),
    );
  }

  Future<void> _signUpHandler(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(
      SignUpParams(email: event.email, password: event.password, fullName: ''),
    );
    emit(const AuthLoadingState());

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

  Future<void> _cacheFirstTimerCheck(CacheFirstTimerEvent event, Emitter<AuthState> emit) async {
    emit(const CachingFirstTimerState());
    final result = await _cacheFirstTimer();
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> _checkIfUserIsFirstTimerCheck(
    CheckIfUserIsFirstTimerEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const CheckingIfUserIsFirstTimerState());
    final result = await _checkIfUserIsFirstTimer();
    result.fold(
      (failure) => emit(const AuthErrorState(message: 'Something went wrong')),
      (status) => emit(AuthStatus(isFirstTimer: status)),
    );
  }
}
