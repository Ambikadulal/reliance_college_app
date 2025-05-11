import 'package:flutter/material.dart';

class LectureListPage extends StatelessWidget {
  const LectureListPage({super.key});

  final List<Map<String, String>> lectures = const [
    {
      'subject': 'Dot net',
      'time': '6:30 AM - 7:30 AM',
      'lecturer': 'Mr. Sharma',
    },
    {
      'subject': 'computer Graphices',
      'time': '7:30 AM - 8:30 AM',
      'lecturer': 'saudher dhungana',
    },
    {'subject': 'break', 'time': '8:30 AM - 9:00 AM', 'lecturer': 'BREAK'},
    {
      'subject': 'e-commerce',
      'time': '9:00 AM - 10:00 AM',
      'lecturer': 'Mrs.sharma',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lecture List"),
        centerTitle: true,
        backgroundColor: Colors.green[100],
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          final lecture = lectures[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.book, color: Colors.deepPurple),
              title: Text(
                lecture['subject'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time: ${lecture['time']}"),
                  Text("Lecturer: ${lecture['lecturer']}"),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
