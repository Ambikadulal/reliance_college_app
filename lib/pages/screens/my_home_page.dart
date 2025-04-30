import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';
import 'package:bca_student_app/pages/screens/dashboard.dart';
import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String email = "";
  String name = "";
  bool isLoggedIn = false;
  bool _isLoading = true; // ✅ Loading flag

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      email = prefs.getString('email') ?? "";
      name = prefs.getString('name') ?? "";

      _widgetOptions = <Widget>[
        StudentDashboard(),
        StudentInfoListView(),
        ProfileScreen(username: name, email: email), 
      ];

      _isLoading = false; 
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () async {}),
        ],
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBarExample(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

