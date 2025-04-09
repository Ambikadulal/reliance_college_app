import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';
import 'package:bca_student_app/pages/screens/dashboard.dart';
import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    StudentDashboard(),
    StudentInfoListView(),
    ProfileScreen(email: '', username: '',),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),

      bottomNavigationBar: BottomNavigationBarExample(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}