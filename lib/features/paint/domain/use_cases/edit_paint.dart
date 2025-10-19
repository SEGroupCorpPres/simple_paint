import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class EditPaint extends UseCaseWithParams<void, EditPaintParams> {
  final PaintRepository _repository;

  EditPaint(this._repository);

  @override
  ResultFuture<void> call(EditPaintParams params) => _repository.updatePaint(paint: params.paint);
}

class EditPaintParams extends Equatable {
  final PaintEntity paint;

  const EditPaintParams({required this.paint});

  @override
  // TODO: implement props
  List<Object?> get props => [paint];
}
