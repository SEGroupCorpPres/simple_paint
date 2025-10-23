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
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> addPaintToLocalDB({required PaintEntity paint}) async {
    try {
      PaintModel paintModel = PaintModel.fromEntity(paint);
      await _localDataSource.insertPaint(paintModel);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> deletePaint({required String id}) async {
    try {
      await _remoteDataSource.deletePaint(paintId: id);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> deletePaintInLocalDB({required String id}) async {
    try {
      await _localDataSource.deletePaint(id);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<PaintEntity> getPaint({required String id}) async {
    try {
      final remoteResult = await _remoteDataSource.getPaint(paintId: id);
      return Right(remoteResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<PaintEntity> getPaintFromLocalDB({required String id}) async {
    try {
      final localResult = await _localDataSource.getPaint(id);
      return Right(localResult!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<List<PaintEntity>?> getPaintsList() async {
    try {
      final remoteResult = await _remoteDataSource.getPaintsList();
      return Right(remoteResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<List<PaintEntity>?> getPaintsListFromLocalDB() async {
    try {
      final localResult = await _localDataSource.getAllPaints();
      return Right(localResult);
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
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }

  @override
  ResultFuture<bool> updatePaintInLocalDB({required PaintEntity paint, required String id}) async {
    try {
      PaintModel paintModel = PaintModel.fromEntity(paint);

      await _localDataSource.updatePaint(paintModel);
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code.toString()));
    }
  }
}
