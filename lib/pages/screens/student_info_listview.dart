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
        students = decoded.map<Map<String, String>>((e) => Map<String, String>.from(e)).toList();
      });
    } else {
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

  void _showAddStudentSheet() {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Student",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: "Student ID",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    final id = idController.text.trim();
                    final name = nameController.text.trim();
                    if (id.isNotEmpty && name.isNotEmpty) {
                      _addStudent(id, name);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Add Student"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Directory"),
        centerTitle: true,
        elevation: 2,
      ),
      body: students.isEmpty
          ? const Center(child: Text("No students added yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(student["id"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(student["name"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text("ID: ${student["id"]}"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You clicked ${student["name"]}')),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddStudentSheet,
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
