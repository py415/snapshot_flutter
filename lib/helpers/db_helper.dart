import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// Blueprint for database helper class which handles instructions for our SQLite database.
class DBHelper {
  // Access SQLite database.
  static Future<sql.Database> database() async {
    // Get path for SQLite database.
    final dbPath = await sql.getDatabasesPath();
    // Open SQLite database.
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        // Create a new SQLite table if one does not already exist.
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  // Insert new data to SQLite database.
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    // Insert new data to SQLite database.
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Fetch data from SQLite database.
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }
}
