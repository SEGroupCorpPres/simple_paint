import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintRepository {
  ResultFuture<PaintEntity> getPaint({required String id});

  ResultFuture<List<PaintEntity>?> getPaintsList();

  ResultFuture<bool> addPaint({required PaintEntity paint, required File image});

  ResultFuture<bool> updatePaint({
    required PaintEntity paint,
    required String id,
    required File? image,
  });

  ResultFuture<bool> deletePaint({required String id});
}
