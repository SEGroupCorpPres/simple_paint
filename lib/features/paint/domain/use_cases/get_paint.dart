import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class GetPaint extends UseCaseWithParams<PaintEntity, GetPaintParams> {
  final PaintRepository _repository;

  GetPaint(this._repository);

  @override
  ResultFuture<PaintEntity> call(GetPaintParams params) =>
      _repository.getPaintFromLocalDB(id: params.id);
}

class GetPaintParams extends Equatable {
  final String id;

  const GetPaintParams({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
