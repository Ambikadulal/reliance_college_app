import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String name = "";

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "Student";
    });
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "🔔 Notifications",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.announcement),
                  title: Text("Final Flutter Project Proposal Submission"),
                  subtitle: Text("Deadline: March 10"),
                ),
                ListTile(
                  leading: Icon(Icons.warning_amber),
                  title: Text("Class Cancelled"),
                  subtitle: Text("Flutter class on Friday is cancelled"),
                ),
              ],
            ),
          ),
    );
  }

  void _showAssignments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "📘 Assignments",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text("Software Engineering Case Study"),
                  subtitle: Text("Due: March 15"),
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text("Web Technology Mini Project"),
                  subtitle: Text("Due: March 20"),
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text("DSA Assignment"),
                  subtitle: Text("Due: March 25"),
                ),
              ],
            ),
          ),
    );
  }

  void _showCalendar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(now);

        return Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "📅 Calendar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Today: $formattedDate",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text("Upcoming Events:"),
              const ListTile(
                leading: Icon(Icons.event),
                title: Text("Unit Test - AI"),
                subtitle: Text("April 10"),
              ),
              const ListTile(
                leading: Icon(Icons.event),
                title: Text("Presentation - Networking"),
                subtitle: Text("April 15"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mockLeaveRequest(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "📩 Leave Request",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Reason: Fever\nDate: April 6, 2025"),
                SizedBox(height: 10),
                Text("Status: Pending", style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
    );
  }

  void _openFeature(String title) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$title tapped!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Namaste, Welcome $name 👋✨"),
        backgroundColor: Colors.deepPurple.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("🎯 Features"),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildFeatureBox(
                    Icons.assignment,
                    "Assignments",
                    () => _showAssignments(context),
                  ),
                  _buildFeatureBox(
                    Icons.calendar_today,
                    "Calendar",
                    () => _showCalendar(context),
                  ),
                  _buildFeatureBox(
                    Icons.mail_outline,
                    "Leave",
                    () => _mockLeaveRequest(context),
                  ),
                  _buildFeatureBox(
                    Icons.grade,
                    "Grades",
                    () => _openFeature("Grades"),
                  ),
                  _buildFeatureBox(
                    Icons.chat,
                    "Messages",
                    () => _openFeature("Messages"),
                  ),
                  _buildFeatureBox(
                    Icons.book,
                    "Library",
                    () => _openFeature("Library"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _sectionTitle("📅 Today's Schedule"),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSubjectBox(
                    "AI",
                    "10:00 AM",
                    Icons.memory,
                    Colors.lightBlue,
                  ),
                  _buildSubjectBox(
                    "C Programming",
                    "11:30 AM",
                    Icons.phone_android,
                    Colors.teal,
                  ),
                  _buildSubjectBox(
                    "Networking",
                    "1:00 PM",
                    Icons.wifi,
                    Colors.pinkAccent,
                  ),
                  _buildSubjectBox(
                    "Music",
                    "2:30 PM",
                    Icons.graphic_eq,
                    Colors.deepOrange,
                  ),
                  _buildSubjectBox(
                    "Maths",
                    "3:30 PM",
                    Icons.calculate,
                    Colors.indigo,
                  ),
                  _buildSubjectBox(
                    "Software Engineering",
                    "4:30 PM",
                    Icons.settings,
                    Colors.green,
                  ),
                  _buildSubjectBox(
                    "WebTech",
                    "5:30 PM",
                    Icons.web,
                    Colors.cyan,
                  ),
                  _buildSubjectBox(
                    "DSA",
                    "6:00 PM",
                    Icons.data_usage,
                    Colors.brown,
                  ),
                  _buildSubjectBox(
                    "Moral Class",
                    "7:00 PM",
                    Icons.school,
                    Colors.purple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFeatureBox(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.deepPurple),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectBox(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
