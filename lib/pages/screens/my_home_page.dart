import 'package:bca_student_app/pages/screens/api/pages/user_list.dart';
import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';
import 'package:bca_student_app/pages/screens/bottom_nav/profile.dart';
import 'package:bca_student_app/pages/screens/dashboard.dart';
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
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF001F3F)),
              child: Text("Drawer Header", style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.yellow),
              title: const Text('Home'),
              tileColor: Colors.grey[200],
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list_alt, color: Colors.pink),
              title: const Text('Student List'),
              tileColor: Colors.grey[200],
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.green),
              title: const Text('Profile'),
              tileColor: Colors.grey[200],
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 20),
            onPressed: () async {
              await _showSettingsMenu(context);
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

  Future<void> _showSettingsMenu(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: Text(
                'All Settings',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              tileColor: Color(0xFF001F3F),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.orange),
              title: Text('General Setting', style: TextStyle(color: Colors.black)),
              tileColor: Colors.grey[200],
              onTap: () {
                Navigator.pop(context);
                _showGeneralSettings(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.share, color: Colors.pink),
              title: Text('Follow Us', style: TextStyle(color: Colors.black)),
              tileColor: Colors.grey[200],
              onTap: () {
                Navigator.pop(context);
                _showFollowUs(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.star, color: Colors.indigo),
              title: Text('Rate Our App', style: TextStyle(color: Colors.black)),
              tileColor: Colors.grey[200],
              onTap: () {
                Navigator.pop(context);
                _showRateOurApp(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description, color: Colors.green),
              title: Text('Terms and Privacy Policy', style: TextStyle(color: Colors.black)),
              tileColor: Colors.grey[200],
              onTap: () {
                Navigator.pop(context);
                _showTermsAndPrivacyPolicy(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFollowUs(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.alternate_email, color: Colors.pink),
              title: Text('Follow Us on Social Media for More Updates', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showGeneralSettings(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.password, color: Colors.orange),
              title: Text('Change Password', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTermsAndPrivacyPolicy(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.visibility, color: Colors.green),
              title: Text('View these Terms and Privacy Policy', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRateOurApp(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.indigo),
              title: Text('If you love our app, please rate it!', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
