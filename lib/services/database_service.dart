import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/history_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'history.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          url TEXT,
          timestamp TEXT
        )
      ''');
    });
  }

  Future<void> insertHistory(HistoryModel history) async {
    final db = await database;
    await db.insert('history', history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<HistoryModel>> getHistory() async {
    final db = await database;
    final maps = await db.query('history', orderBy: 'timestamp DESC');
    return maps.map((map) => HistoryModel.fromMap(map)).toList();
  }
}