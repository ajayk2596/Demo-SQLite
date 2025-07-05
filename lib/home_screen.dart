import 'package:demo_sqflite/db_helper.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Screen"),
            TextField(
              controller: nameController,
            ),
            ElevatedButton(onPressed: ()async{
             await DBHelper.insertData(nameController.text);
            }, child: Text("add data"))
          ],
        ),
      ),
    );
  }
}
