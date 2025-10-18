import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  CacheFirstTimer(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer(); //=>
}
