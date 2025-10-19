import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class GetPaintsList extends UseCaseWithoutParams<List<PaintEntity>> {
  final PaintRepository _repository;

  GetPaintsList(this._repository);

  @override
  ResultFuture<List<PaintEntity>> call() {
    return _repository.getPaintsList();
  }
}
