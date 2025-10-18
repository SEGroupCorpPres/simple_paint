import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';


class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  CheckIfUserIsFirstTimer(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.checkIfUserIsFirstTimer();
}
