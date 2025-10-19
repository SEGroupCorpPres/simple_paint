import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class AddPaint extends UseCaseWithParams<bool, AddPaintParams> {
  final PaintRepository _repository;

  AddPaint(this._repository);

  @override
  ResultFuture<bool> call(AddPaintParams params) =>
      _repository.addPaint(paint: params.paint, image: params.image);
}

class AddPaintParams extends Equatable {
  final PaintEntity paint;
  final File image;

  const AddPaintParams(this.image, {required this.paint});

  @override
  // TODO: implement props
  List<Object?> get props => [paint, image];
}
