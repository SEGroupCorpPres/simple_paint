import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signUp({required String email, required String password, required String fullName});

  Future<void> signOut({required String uid});

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  const AuthLocalDataSourceImp(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
    required String fullName,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut({required String uid}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String password, required String fullName}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _preferences.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _preferences.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
