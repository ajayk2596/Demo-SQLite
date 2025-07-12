import 'package:demo_sqflite/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DataModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  List<DataModel> studentList = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final data = await DatabaseHelper.viewData();
    if (data != null) {
      setState(() {
        studentList = data;
      });
    }
  }

  Future<void> addStudent() async {
    if (nameController.text.trim().isEmpty) return;
    final newStudent = DataModel(
      id: null,
      name: nameController.text.trim(),
      image: '', // Default empty image, adjust as needed
    );
    await DatabaseHelper.insertData(newStudent);
    nameController.clear();
    await fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students DB")),
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addStudent,
              child: const Text("Add Data"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  final student = studentList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(student.id?.toString() ?? '')),
                      title: Text(student.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              updateNameController.text = student.name;
                              final id = student.id;
                              if (id != null) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Update Student"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: updateNameController,
                                            decoration: InputDecoration(
                                              labelText: "Enter New Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (updateNameController.text.trim().isNotEmpty) {
                                              final updatedModel = DataModel(
                                                id: id,
                                                name: updateNameController.text.trim(),
                                                image: student.image, // Retain old image or update as needed
                                              );
                                              await DatabaseHelper.updateData(id, updatedModel);
                                              await fetchStudents();
                                              Navigator.pop(context);
                                              HapticFeedback.vibrate();
                                            }
                                          },
                                          child: Text("Update"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final id = student.id;
                              if (id != null) {
                                await DatabaseHelper.deleteData(id);
                                await fetchStudents();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}