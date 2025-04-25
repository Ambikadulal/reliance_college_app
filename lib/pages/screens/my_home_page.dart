import 'package:bca_student_app/pages/screens/Api/user_list.dart';
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

  static List<Widget> _widgetOptions = <Widget>[
    //StudentDashboard(),
    UserListScreen(),
    StudentInfoListView(),
    ProfileScreen(email: '', username: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String email = "";
  String name = "";
  bool isLoggedIn = false;

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
      _buildWidgetOptions();
    });
  }

  void _buildWidgetOptions() {
    _widgetOptions = <Widget>[
      StudentDashboard(),
      StudentInfoListView(),
      ProfileScreen(email: '', username: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Home'), onTap: () {}),
            ListTile(title: const Text('Student_List'), onTap: () {}),
            ListTile(title: const Text('Profile'), onTap: () {}),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');
              await prefs.remove('email');
            },
          ),
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
