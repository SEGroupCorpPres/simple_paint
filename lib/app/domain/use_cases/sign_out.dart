import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class SignOut extends UseCaseWithoutParams<void> {
  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  @override
  ResultFuture<void> call() => _authRepository.signOut();
}
