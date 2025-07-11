import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static Database? _db;
  static Future<Database?> get database async{
    if(_db!=null){
      return _db;
    }
    else{
      _db=await createDatabase();
      return _db;
    }
  }
  static Future<Database?> createDatabase()async{
    try{
      Directory directory=await getApplicationDocumentsDirectory();
      String path=join(directory.path,"Raman.DB");
      print("cteated database successfully");
       return await openDatabase(path,version: 1);
    }
    catch(e){
      print("no created database");
    }
  }
}