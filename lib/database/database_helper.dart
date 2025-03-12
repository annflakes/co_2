import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/test_result.dart'; // Import the TestResult model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'test_results.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE results(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            testType TEXT,
            correctAnswers INTEGER,
            incorrectAnswers INTEGER,
            diagnosis TEXT,
            date TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> insertResult(TestResult result) async {
    final db = await database;
    return db.insert('results', result.toMap());
  }

  Future<List<TestResult>> getResults() async {
    final db = await database;
    final maps = await db.query('results');
    return List.generate(
      maps.length,
      (i) => TestResult.fromMap(maps[i]),
    );
  }

  Future<void> clearResults() async {
    final db = await database;
    await db.delete('results');
  }
}
