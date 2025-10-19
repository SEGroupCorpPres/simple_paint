import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';
class PaintRepositoryImpl extends PaintRepository{
  @override
  ResultFuture<void> addPaint({required PaintEntity paint, required File image}) {
    // TODO: implement addPaint
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deletePaint({required String id}) {
    // TODO: implement deletePaint
    throw UnimplementedError();
  }

  @override
  ResultFuture<PaintEntity> getPaint({required String id}) {
    // TODO: implement getPaint
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<PaintEntity>> getPaintsList() {
    // TODO: implement getPaintsList
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updatePaint({required PaintEntity paint}) {
    // TODO: implement updatePaint
    throw UnimplementedError();
  }
}