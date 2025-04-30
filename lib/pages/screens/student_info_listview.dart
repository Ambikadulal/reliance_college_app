import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentInfoListView extends StatefulWidget {
  const StudentInfoListView({super.key});

  @override
  State<StudentInfoListView> createState() => _StudentInfoListViewState();
}

class _StudentInfoListViewState extends State<StudentInfoListView> {
  List<Map<String, String>> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedList = prefs.getString('students');
    if (storedList != null) {
      final List decoded = jsonDecode(storedList);
      setState(() {
        students =
            decoded
                .map<Map<String, String>>((e) => Map<String, String>.from(e))
                .toList();
      });
    } else {
      // Default list (optional)
      students = [
        {"id": "1", "name": "Aarav Sharma"},
      ];
      await _saveStudents();
    }
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('students', jsonEncode(students));
  }

  void _addStudent(String id, String name) {
    setState(() {
      students.add({"id": id, "name": name});
    });
    _saveStudents();
  }

  void _showAddDialog() {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

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
                  decoration: const InputDecoration(labelText: "ID"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final id = idController.text.trim();
                  final name = nameController.text.trim();
                  if (id.isNotEmpty && name.isNotEmpty) {
                    _addStudent(id, name);
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
      appBar: AppBar(title: const Text("Student List")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(child: Text(students[index]["id"]!)),
              title: Text(
                students[index]["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Student ID: ${students[index]["id"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${students[index]["name"]} tapped!')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
