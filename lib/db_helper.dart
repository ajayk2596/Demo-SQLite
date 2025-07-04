import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static Future<Database?> get database async{
    if(_db!=null){
      return _db;
    }
    else{
      _db= await initialDatabase();
      return _db;
    }
  }
 static Future<Database?> initialDatabase()async{
    try{
      Directory directory=await getApplicationDocumentsDirectory();
      String path=join(directory.path,"Edugaon.db");
    Database db=  await openDatabase(path,version: 1,onCreate: _onCreate);
      print("database created successfully");
      return db;
    }
    catch(e){
      print("errors:$e");
      print("no database created");
      return null;
    }
  }
  static Future<void> _onCreate(Database db, int version)async{
try{
  await db.execute('CREATE TABLE Students (id INTEGER  PRIMARY KEY AUTOINCREMENT, name VARCHAR(30))');
  print("Table created successfully");
}
 catch(e){
  print("errors table:$e");
  print("no table created in the database");
 }

  }

static Future<void> insertData(String name)async{
  Database? db=await database;
    try{
     if(db!=null){
       await db.insert("Students", {
         "name":name
       });

       print("insert data successfully");
     }
     else{
       print("database is null");
     }
    }
    catch(e){
      print("insert errors:$e");
      print("no insert data");
    }
}
}
