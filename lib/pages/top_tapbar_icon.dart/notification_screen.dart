import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: use_key_in_widget_constructors
class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Attendance',
      'subtitle':
          'Dear Sudeep\n your attendance has been mark as presents in class today.',
      'time': '20 min ago',
    },
    {
      'title': 'Networking Assignment due',
      'subtitle': 'Submit your lab report after mid term examaination.',
      'time': '20 min ago',
    },
    {
      'title': 'Exam Schedule Released',
      'subtitle': 'Check the timetable for the MidTerm exams.',
      'time': '1 hour ago',
    },
    {
      'title': 'Holiday',
      'subtitle':
          'Student there will be holiday on Thursday due to labour day.',
      'time': '3 hours ago',
    },
    {
      'title': 'DOT NET ',
      'subtitle': 'please submit your assigment on time .',
      'time': '25 April',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.green[100],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: 1,
                child: Lottie.asset(
                  'assets/notification.json',
                  height: 450,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),

          ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var item = notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  // ignore: deprecated_member_use
                  color: Colors.amberAccent[100],
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: Icon(Icons.school, color: Colors.blue),
                    title: Text(
                      item['title']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item['subtitle']!),
                    trailing: Text(
                      item['time']!,
                      style: TextStyle(color: Colors.grey[900], fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
