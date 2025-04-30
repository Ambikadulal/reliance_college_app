import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("📅 Today's Schedule"),
          _buildCard(
            icon: Icons.computer,
            title: "Artificial Intelligence",
            subtitle: "10:00 AM - 11:30 AM | Lab 304",
            color: Colors.blue.shade100,
          ),
          _buildCard(
            icon: Icons.developer_mode,
            title: "Mobile App Development",
            subtitle: "1:00 PM - 2:30 PM | Room 207",
            color: Colors.green.shade100,
          ),

          const SizedBox(height: 16),

          _sectionTitle("📢 Important Announcements"),
          _buildCard(
            icon: Icons.announcement,
            title: "Final Project Proposal Submission",
            subtitle: "Deadline: March 10. Submit via college portal.",
            color: Colors.orange.shade100,
          ),

          const SizedBox(height: 16),

          _sectionTitle("📝 Upcoming Assignments"),
          _buildCard(
            icon: Icons.assignment,
            title: "Software Engineering Case Study",
            subtitle: "Due Date: March 15 | Submit via Google Classroom",
            color: Colors.purple.shade100,
          ),

          const SizedBox(height: 16),

          _sectionTitle("📊 Attendance Summary"),
          _buildAttendanceProgress(0.92, "92% Attendance"),

          const SizedBox(height: 24),

          _sectionTitle("🏆 Leaderboard"),
          _buildCard(
            icon: Icons.emoji_events,
            title: "Sujan Karki",
            subtitle: "Top Performer in AI & ML",
            color: Colors.yellow.shade100,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.black87),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildAttendanceProgress(double value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            color: Colors.green,
            backgroundColor: Colors.grey.shade300,
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
