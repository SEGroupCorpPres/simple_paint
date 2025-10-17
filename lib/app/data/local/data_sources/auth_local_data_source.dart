import 'package:simple_paint/app/app_barrels.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signUp({required String email, required String password, required String fullName});

  Future<void> signOut({required String uid});
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {
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
}
