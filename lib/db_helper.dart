import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  static Database? _db;

  ///  get database
 static Future<Database?> get database async{

   if(_db!=null){
     return _db;
   }
   else{
     ///  call creating database method
     _db= await createDatabase();
     return _db;
   }
  }
  /// create database
  static Future<Database?> createDatabase()async{
  try{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,"Edugaon");
    print("created database successfully");
    return await openDatabase(path,version: 1,onCreate: createTable);

  }
  catch(e){
    print("errors:$e");
    print("no database created");
return null;
  }
  }
  /// create table
 static Future<void> createTable(Database db,int version)async{
  try{
    await db.execute('CREATE TABLE Students (id INTEGER  PRIMARY KEY AUTOINCREMENT,name TEXT)');
    print("table created successfully");
  }
  catch(e){
    print("table errors:$e");
    print("no table created");
  }

 }

 /// insert data in a table

 static Future<void> insertData(String name)async{
   Database? db=await database;

   try{
    if(db!=null){
      await db.insert("Students", {"name":name});
      print("data inserted successfully");
    }
    else{
      print("data base is null");
    }

   }
   catch(e){
     print("insert data errors:$e");
     print("no data inserted");

   }
}


}