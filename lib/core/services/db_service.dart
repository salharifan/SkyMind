import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database
    String path = join(await getDatabasesPath(), 'skymind.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cityName TEXT UNIQUE
          )
          ''');
      },
    );
  }

  Future<int> insertFavorite(String cityName) async {
    final db = await database;
    return await db.insert('favorites', {
      'cityName': cityName,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<String>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return maps[i]['cityName'] as String;
    });
  }

  Future<int> deleteFavorite(String cityName) async {
    final db = await database;
    return await db.delete(
      'favorites',
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
  }
}
