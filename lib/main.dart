import 'package:demo_sqflite/db_helper.dart';
import 'package:demo_sqflite/home_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.database;
  await DBHelper.insertData("Vikram");
  await DBHelper.insertData("Arbind");
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

