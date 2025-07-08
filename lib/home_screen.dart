import 'package:demo_sqflite/db_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    List<Map<String, dynamic>>? data = await DBHelper.viewData();
    if (data != null) {
      setState(() {
        studentList = data;
      });
    }
  }

  Future<void> addStudent() async {
    await DBHelper.insertData(nameController.text);
    nameController.clear();
    await fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students DB")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addStudent,
              child: Text("Add Data"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text(studentList[index]['id'].toString())),
                    title: Text(studentList[index]['name']),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
