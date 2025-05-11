import 'package:bca_student_app/pages/screens/Home_subpage/academic_page.dart';
import 'package:bca_student_app/pages/screens/Home_subpage/billing_page.dart';
import 'package:bca_student_app/pages/screens/Home_subpage/exam_page.dart';
import 'package:bca_student_app/pages/screens/Home_subpage/others_page.dart';
import 'package:bca_student_app/pages/screens/api/user_list.dart';
import 'package:bca_student_app/pages/screens/bottom_nav/bottom_navigation_bar.dart';
import 'package:bca_student_app/pages/screens/drawer/attendance.dart';
import 'package:bca_student_app/pages/screens/drawer/calender.dart';
import 'package:bca_student_app/pages/screens/drawer/lecture.dart';
import 'package:bca_student_app/pages/screens/drawer/perfomance.dart';
import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:bca_student_app/pages/top_tapbar_icon.dart/notification_screen.dart';
import 'package:bca_student_app/pages/top_tapbar_icon.dart/settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    UserListScreen(),
    StudentInfoListView(),
    ProfileScreen(email: '', username: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.brown[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/welcome.json',
                    height: 130,
                    // height: 170,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 6),
                  // Text(
                  //   "Hi, Welcome Back!",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
              // child: const Text(
              //   "HI, Welcome Back!",
              //   style: TextStyle(color: Colors.black),
              // ),
            ),

            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendancePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Lecturer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LectureListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Performance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerformancePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('calender'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProfileScreen(email: '', username: ''),
                  ),
                );
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                ),
                minimumSize: WidgetStateProperty.all<Size>(
                  Size(30, 40),
                ), // smaller size
                backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              child: Text(
                "Login",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: ListTile(
          title: const Text(
            "Hii, Welcome Back!",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.904),
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: const Text(
            "Sudeep Bhattarai",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
        ),
        bottom:
            _selectedIndex == 0
                ? TabBar(
                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(icon: Icon(Icons.home, color: Colors.black)),
                    Tab(icon: Icon(Icons.feed, color: Colors.black)),
                  ],
                )
                : null,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notification_add_outlined,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black, size: 25),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),

      body:
          _selectedIndex == 0
              ? TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: const [
                        AcademicsSection(),
                        ExamSection(),
                        BillingPage(),
                        OthersPage(),
                        OthersPage(),
                      ],
                    ),
                  ),
                  const UserListScreen(),
                ],
              )
              : _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarExample(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
