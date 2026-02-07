import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  static Database? _database;

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "pulsebrew_local.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE intake_logs (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        beverage_name TEXT,
        caffeine_amount_mg REAL,
        timestamp TEXT,
        synced INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE biometrics (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        heart_rate_bpm INTEGER,
        activity_level TEXT,
        timestamp TEXT,
        synced INTEGER DEFAULT 0
      )
    ''');
  }

  // --- Intake Logs Operations ---

  Future<int> insertIntake(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('intake_logs', row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUnsyncedIntakes() async {
    Database db = await database;
    return await db.query('intake_logs', where: 'synced = ?', whereArgs: [0]);
  }

  Future<int> markIntakeSynced(String id) async {
    Database db = await database;
    return await db.update('intake_logs', {'synced': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllIntakes() async {
    Database db = await database;
    return await db.query('intake_logs', orderBy: "timestamp DESC");
  }

  // --- Biometrics Operations ---

  Future<int> insertBiometric(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('biometrics', row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUnsyncedBiometrics() async {
    Database db = await database;
    return await db.query('biometrics', where: 'synced = ?', whereArgs: [0]);
  }

  Future<int> markBiometricSynced(String id) async {
    Database db = await database;
    return await db.update('biometrics', {'synced': 1},
        where: 'id = ?', whereArgs: [id]);
  }
}
