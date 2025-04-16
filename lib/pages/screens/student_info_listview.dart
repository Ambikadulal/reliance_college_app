import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final String name;
  final String description;

  Student({required this.name, required this.description});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(name: json['name'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }
}

class StudentInfoListView extends StatefulWidget {
  const StudentInfoListView({super.key});

  @override
  StudentInfoListViewState createState() => StudentInfoListViewState();
}

class StudentInfoListViewState extends State<StudentInfoListView> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('students');

    if (storedData != null) {
      final List<dynamic> data = json.decode(storedData);
      students = data.map((json) => Student.fromJson(json)).toList();
    }

    setState(() {});
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      students.map((s) => s.toJson()).toList(),
    );
    await prefs.setString('students', encodedData);
  }

  Future<void> _addStudentDialog() async {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Student"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final desc = descController.text.trim();
                  if (name.isNotEmpty && desc.isNotEmpty) {
                    setState(() {
                      students.add(Student(name: name, description: desc));
                    });
                    _saveToPrefs();
                  }
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Student Info List'),
      //   // backgroundColor: Colors.blueGrey,
      // ),
      body:
          students.isEmpty
              ? const Center(child: Text("No students yet. Tap + to add."))
              : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(student.name),
                      subtitle: Text(student.description),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${student.name} tapped!')),
                        );
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudentDialog,
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
