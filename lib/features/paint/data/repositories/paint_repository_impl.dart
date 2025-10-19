import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class PaintRepositoryImpl implements PaintRepository {
  PaintRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final PaintRemoteDataSource _remoteDataSource;
  final PaintLocalDataSource _localDataSource;

  @override
  ResultFuture<bool> addPaint({required PaintEntity paint, required File image}) async {
    try {
      PaintModel paintModel = PaintModel.fromEntity(paint);
      await _remoteDataSource.addPaint(paint: paintModel, image: image);
      // final localResult = _localDataSource.addPaint(paint: paint, image: image);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> deletePaint({required String id}) async {
    try {
      await _remoteDataSource.deletePaint(paintId: id);
      // final localResult = _localDataSource.deletePaint(id: id);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<PaintEntity> getPaint({required String id}) async {
    try {
      final remoteResult = await _remoteDataSource.getPaint(paintId: id);
      // final localResult = _localDataSource.getPaint(id: id);
      return Right(remoteResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<List<PaintEntity>?> getPaintsList() async {
    try {
      final remoteResult = await _remoteDataSource.getPaintsList();
      // final localResult = _localDataSource.getPaintsList();
      return Right(remoteResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> updatePaint({
    required PaintEntity paint,
    required File? image,
    required String id,
  }) async {
    try {
      PaintModel paintModel = PaintModel.fromEntity(paint);
      await _remoteDataSource.updatePaint(paint: paintModel, image: image, paintId: id);

      // final localResult = _localDataSource.updatePaint(paint: paint);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }
}
