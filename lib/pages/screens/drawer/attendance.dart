import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Map<String, dynamic>> subjects = [
    {'subject': 'dot net', 'isPresent': false},
    {'subject': 'computer graphices', 'isPresent': false},
    {'subject': 'e-learning', 'isPresent': false},
    {'subject': 'interoduction to management', 'isPresent': false},
    {'subject': 'networking', 'isPresent': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.checklist),
              title: Text(subjects[index]['subject']),
              trailing: Switch(
                value: subjects[index]['isPresent'],
                onChanged: (value) {
                  setState(() {
                    subjects[index]['isPresent'] = value;
                  });
                },
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
