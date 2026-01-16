import 'package:sqflite/sqflite.dart';

class LocalDB {
  static Future<Database> open() async {
    return openDatabase("pulsebrew.db", version: 1,
      onCreate: (db, _) {
        db.execute("""
        CREATE TABLE biometrics(
          ts INTEGER,
          hr REAL,
          hrv REAL,
          stress REAL
        )
        """);
      });
  }
}
