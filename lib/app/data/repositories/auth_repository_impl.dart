import 'package:simple_paint/app/data/data.dart';
import 'package:simple_paint/core/core.dart';

class AuthRepositoryImp implements AuthRepository {
  const AuthRepositoryImp(this._authRemoteDataSource, this._localDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  ResultFuture<LocalUser> signIn({required String email, required String password}) async {
    try {
      final user = await _authRemoteDataSource.signIn(email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.signUp(email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    }
  }

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
