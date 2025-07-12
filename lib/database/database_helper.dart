import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../DataModel.dart';

class DatabaseHelper {
  static Database? _db;

  /// Get database
  static Future<Database?> get database async {
    if (_db != null) {
      return _db;
    } else {
      /// Call creating database method
      _db = await createDatabase();
      return _db;
    }
  }

  /// Create database
  static Future<Database?> createDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, "Edugaon.db");
      print("Database created successfully");
      return await openDatabase(path, version: 1, onCreate: createTable);
    } catch (e) {
      print("Error: $e");
      print("No database created");
      return null;
    }
  }

  /// Create table
  static Future<void> createTable(Database db, int version) async {
    try {
      await db.execute(
          'CREATE TABLE Students (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, image TEXT)');
      print("Table created successfully");
    } catch (e) {
      print("Table error: $e");
      print("No table created");
    }
  }

  /// Insert data into a table
  static Future<void> insertData(DataModel dataModel) async {
    Database? db = await database;
    try {
      if (db != null) {
        await db.insert("Students", dataModel.toJson());
        print("Data inserted successfully");
      } else {
        print("Database is null");
      }
    } catch (e) {
      print("Insert data error: $e");
      print("No data inserted");
    }
  }

  /// View data from a table
  static Future<List<DataModel>?> viewData() async {
    Database? db = await database;
    try {
      if (db != null) {
       List<Map<String,dynamic>> data=await db.query("Students");
     return data.map((json)=>DataModel.fromJson(json)).toList();
      } else {
        print("Database is null");
        return null;
      }
    } catch (e) {
      print("Data view error: $e");
      return null;
    }
  }

  /// Delete data from a table
  static Future<void> deleteData(int id) async {
    Database? db = await database;
    try {
      if (db != null) {
        await db.delete("Students", where: "id = ?", whereArgs: [id]);
        print("Data deleted successfully");
      } else {
        print("Database is null");
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }

  /// Update data in a table
  static Future<void> updateData(int id, DataModel updatedModel) async {
    Database? db = await database;
    try {
      if (db != null) {
        await db.update(
          "Students",
          updatedModel.toJson(),
          where: "id = ?",
          whereArgs: [id],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        print("Data updated successfully");
      } else {
        print("Database is null");
      }
    } catch (e) {
      print("Update error: $e");
    }
  }
}