import 'package:demo_sqflite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final data = await DBHelper.viewData();
    if (data != null) {
      setState(() {
        studentList = data;
      });
    }
  }

  Future<void> addStudent() async {
    if (nameController.text.trim().isEmpty) return;
    await DBHelper.insertData(nameController.text.trim());
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
                  final int id = student['id'];
                  final String name = student['name'];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(id.toString())),
                      title: Text(name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: ()async {
                              var data=studentList[index];
                              updateNameController.text = data['name'];
                                String updatedName = updateNameController.text.trim();
                                if(updatedName.isNotEmpty){
                                  await DBHelper.updateData(id, name);
                                  await fetchStudents();
                                }

                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      TextField(
                                        controller: updateNameController,
                                        decoration: InputDecoration(
                                          labelText: "Enter Your Name",
                                          border: OutlineInputBorder()
                                        ),
                                      ),
                                      MaterialButton(onPressed: ()async{
                                        await DBHelper.updateData(id, updateNameController.text);
                                        await fetchStudents();
                                        Navigator.pop(context);
                                        HapticFeedback.vibrate();
                                      },child: Text("Update Data"),
                                      height: 50, minWidth: 150, color: Colors.teal,
                                      )
                                    ],
                                  ),
                                );
                              },
                              );

                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color:Colors.red),
                            onPressed: () async {
                              final id=studentList[index]['id'];
                             await DBHelper.deleteData(id);
                             await fetchStudents();
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
