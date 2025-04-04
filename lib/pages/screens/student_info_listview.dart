import 'dart:convert';
import 'package:bca_student_app/pages/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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

  Future<void> _addOrEditStudentDialog({int? index}) async {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    if (index != null) {
      nameController.text = students[index].name;
      descController.text = students[index].description;
    }

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(index == null ? "Add Student" : "Edit Student"),
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
                      if (index == null) {
                        students.add(Student(name: name, description: desc));
                      } else {
                        students[index] = Student(
                          name: name,
                          description: desc,
                        );
                      }
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

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    _addOrEditStudentDialog(index: index);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      students.removeAt(index);
                    });
                    _saveToPrefs();
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body:
          students.isEmpty
              ? const Center(child: Text("No students yet. Tap + to add."))
              : AnimationLimiter(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 0,

                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.indigo[100],
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              title: Text(
                                student.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(student.description),
                              trailing: IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () => _showOptions(index),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => StudentDetailScreen(
                                          student: student,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _addOrEditStudentDialog(),
        backgroundColor: Colors.indigo[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
