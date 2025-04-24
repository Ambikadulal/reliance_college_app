import 'dart:convert';
import 'package:bca_student_app/pages/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

    if (storedData != null && storedData.isNotEmpty) {
      try {
        final List<dynamic> data = json.decode(storedData);
        students = data.map((json) => Student.fromJson(json)).toList();
      } catch (e) {
        debugPrint("Error decoding student data: $e");
      }
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

    if (index != null && index < students.length) {
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
      backgroundColor: Colors.green[100],
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              "assets/animation2.json",
              fit: BoxFit.cover,
              animate: true,
              repeat: true,
            ),
          ),
          students.isEmpty
              ? const Center(child: Text("No students yet. Tap + to add."))
              : ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return Card(
                    color: Colors.brown[100],
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[300],
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(student.name),
                      subtitle: Text(student.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white,
                        onPressed: () => _showOptions(index),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    StudentDetailScreen(student: student),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _addOrEditStudentDialog(),
        backgroundColor: Colors.green[100],
        child: const Icon(Icons.add),
      ),
    );
  }
}
