import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Student {
  final String name;
  final String description;

  Student({required this.name, required this.description});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(name: json['name'], description: json['description']);
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
    final String response = await rootBundle.loadString(
      'lib/assets/student.json',
    );
    final List<dynamic> data = json.decode(response);
    setState(() {
      students = data.map((json) => Student.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return students.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        );
  }
}
