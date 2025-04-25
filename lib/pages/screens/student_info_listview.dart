import 'dart:convert';
import 'package:flutter/material.dart';

class Student {
  final int id;
  final String name;

  Student({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Student.fromJson(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name']);
}

class StudentInfoListView extends StatefulWidget {
  const StudentInfoListView({super.key});

  @override
  State<StudentInfoListView> createState() => _StudentInfoListViewState();
}

class _StudentInfoListViewState extends State<StudentInfoListView> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('student_list');
    if (data != null) {
      final List decoded = jsonDecode(data);
      setState(() {
        students = decoded.map((e) => Student.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(students.map((s) => s.toJson()).toList());
    await prefs.setString('student_list', encoded);
  }

  void _showAddStudentDialog() {
    final idController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Add New Student"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: "Student ID"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Student Name"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final id = int.tryParse(idController.text.trim());
                  final name = nameController.text.trim();

                  if (id != null && name.isNotEmpty) {
                    setState(() {
                      students.add(Student(id: id, name: name));
                    });
                    await _saveStudents();
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${student.id}')),
                      title: Text(
                        student.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Student ID: ${student.id}"),
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
        onPressed: _showAddStudentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SharedPreferences {
  static getInstance() {}
}
