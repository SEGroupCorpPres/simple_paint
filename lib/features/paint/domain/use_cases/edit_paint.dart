import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class EditPaint extends UseCaseWithParams<bool, EditPaintParams> {
  final PaintRepository _repository;

  EditPaint(this._repository);

  @override
  ResultFuture<bool> call(EditPaintParams params) =>
      _repository.updatePaint(paint: params.paint, id: params.id, image: params.image);
}

class EditPaintParams extends Equatable {
  final PaintEntity paint;
  final String id;
  final File? image;

  const EditPaintParams({required this.id, required this.paint, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [paint, id];
}
