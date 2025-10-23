import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class DeletePaint extends UseCaseWithParams<bool, DeletePaintParams> {
  final PaintRepository _repository;

  DeletePaint(this._repository);

  @override
  ResultFuture<bool> call(DeletePaintParams params) {
    return _repository.deletePaintInLocalDB(id: params.id);
  }
}

class DeletePaintParams extends Equatable {
  final String id;

  const DeletePaintParams({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
