import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintRepository {
  ResultFuture<PaintEntity> getPaint({required String id});

  ResultFuture<List<PaintEntity>> getPaintsList();

  ResultFuture<void> addPaint({required PaintEntity paint, required File image});

  ResultFuture<void> updatePaint({required PaintEntity paint});

  ResultFuture<void> deletePaint({required String id});
}
