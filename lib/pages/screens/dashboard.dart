import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<int> _totalStudents;
  late Future<int> _totalCourses;
  late Future<List<String>> _latestNotices;
  int attendancePercent = 0;

  @override
  void initState() {
    super.initState();
    _totalStudents = fetchTotalStudents();
    _totalCourses = fetchTotalCourses();
    _latestNotices = fetchLatestNotices();
    attendancePercent = Random().nextInt(41) + 60; // Random between 60–100
  }

  Future<int> fetchTotalStudents() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );
    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.length;
    } else {
      throw Exception("Failed to load students");
    }
  }

  Future<int> fetchTotalCourses() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.length; // Pretend these are courses
    } else {
      throw Exception("Failed to load courses");
    }
  }

  Future<List<String>> fetchLatestNotices() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.take(3).map<String>((e) => e['title'] as String).toList();
    } else {
      throw Exception("Failed to load notices");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimationLimiter(
          child: FutureBuilder(
            future: Future.wait([
              _totalStudents,
              _totalCourses,
              _latestNotices,
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset('assets/loading.json', width: 150),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final totalStudents = snapshot.data![0] as int;
              final totalCourses = snapshot.data![1] as int;
              final latestNotices = snapshot.data![2] as List<String>;

              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildCard(
                    title: "Total Students",
                    value: totalStudents.toString(),
                    icon: Icons.school,
                    color: Colors.blueAccent,
                  ),
                  _buildCard(
                    title: "Total Courses",
                    value: totalCourses.toString(),
                    icon: Icons.book,
                    color: Colors.deepPurpleAccent,
                  ),
                  _buildCard(
                    title: "Today's Attendance",
                    value: "$attendancePercent%",
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                  _buildNoticesCard(latestNotices),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return AnimationConfiguration.staggeredGrid(
      position: Random().nextInt(20),
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: SlideAnimation(
          horizontalOffset: 50,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticesCard(List<String> notices) {
    return AnimationConfiguration.staggeredGrid(
      position: Random().nextInt(20),
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: SlideAnimation(
          verticalOffset: 50,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFE0F7FA),
                  child: Icon(Icons.notifications, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Latest Notices",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                ...notices.map(
                  (notice) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      "- $notice",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
