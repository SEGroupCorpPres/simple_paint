import 'package:simple_paint/core/core.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('simple_paint_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // Users table

    // Paints table
    await db.execute('''
      CREATE TABLE paints (
        paintId TEXT PRIMARY KEY,
        imageUrl TEXT,
        uid TEXT,
        created TEXT NOT NULL,
        updated TEXT NOT NULL
      )
    ''');

    // Create indexes
    await db.execute('CREATE INDEX idx_paints_uid ON paints(uid)');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
