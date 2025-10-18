import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

abstract class AuthRepository {
  ResultFuture<LocalUser> signIn({required String email, required String password});

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> signOut();

  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
