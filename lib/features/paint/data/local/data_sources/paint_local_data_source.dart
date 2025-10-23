import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintLocalDataSource {
  Future<void> insertPaint(PaintModel paint);

  Future<PaintModel?> getPaint(String paintId);

  Future<List<PaintModel>> getAllPaints();

  Future<void> updatePaint(PaintModel paint);

  Future<void> deletePaint(String paintId);
}

class PaintLocalDataSourceImpl implements PaintLocalDataSource {
  final DatabaseHelper _dbHelper;

  PaintLocalDataSourceImpl(this._dbHelper);

  @override
  Future<void> insertPaint(PaintModel paint) async {
    final db = await _dbHelper.database;
    await db.insert('paints', paint.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<PaintModel?> getPaint(String paintId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('paints', where: 'paintId = ?', whereArgs: [paintId]);

    if (maps.isEmpty) return null;
    return PaintModel.fromMap(maps.first);
  }

  @override
  Future<List<PaintModel>> getAllPaints() async {
    final db = await _dbHelper.database;
    final maps = await db.query('paints', orderBy: 'created DESC');
    return maps.map((map) => PaintModel.fromMap(map)).toList();
  }

  @override
  Future<void> updatePaint(PaintModel paint) async {
    final db = await _dbHelper.database;
    await db.update('paints', paint.toMap(), where: 'paintId = ?', whereArgs: [paint.paintId]);
  }

  @override
  Future<void> deletePaint(String paintId) async {
    final db = await _dbHelper.database;
    await db.delete('paints', where: 'paintId = ?', whereArgs: [paintId]);
  }
}
