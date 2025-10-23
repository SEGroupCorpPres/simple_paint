import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintRepository {
  ResultFuture<PaintEntity> getPaint({required String id});

  ResultFuture<PaintEntity> getPaintFromLocalDB({required String id});

  ResultFuture<List<PaintEntity>?> getPaintsList();

  ResultFuture<List<PaintEntity>?> getPaintsListFromLocalDB();

  ResultFuture<bool> addPaint({required PaintEntity paint, required File image});

  ResultFuture<bool> addPaintToLocalDB({required PaintEntity paint});

  ResultFuture<bool> updatePaint({
    required PaintEntity paint,
    required String id,
    required File? image,
  });

  ResultFuture<bool> updatePaintInLocalDB({required PaintEntity paint, required String id});

  ResultFuture<bool> deletePaint({required String id});

  ResultFuture<bool> deletePaintInLocalDB({required String id});
}
