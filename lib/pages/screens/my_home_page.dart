import 'package:flutter/material.dart';
import 'package:bca_student_app/pages/screens/dashboard_screen.dart';
import 'package:bca_student_app/pages/screens/events_screen.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(), // index 0
    EventScreen(), // index 1
    StudentInfoListView(), // index 2
    ProfileScreen(), // index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        elevation: 2,
        title: const Text("Student App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {
              // Add your notification logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              // Add your settings logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings clicked!')),
              );
            },
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarExample(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
