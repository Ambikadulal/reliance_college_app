import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:flutter/material.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Detail"),
        backgroundColor: const Color.fromARGB(255, 30, 195, 118),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for ProfilePicture
            CircleAvatar(
              radius: 50,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 29, 92, 239),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              student.name.toUpperCase(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              student.description,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
