import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';
import 'package:bca_student_app/pages/screens/dashboard.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.email,
    required this.username,
  });

  final String title;
  final String email;
  final String username;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptionsWithData(String email, String username) => [
    StudentDashboard(),
    StudentInfoListView(),
    ProfileScreen(email: email, username: username),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgets = _widgetOptionsWithData(widget.email, widget.username);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: widgets[_selectedIndex]),

      bottomNavigationBar: BottomNavigationBarExample(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
    
  }
}
