import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/student.dart';

class StudentPrefs {
  static const String _key = "student_list";

  static Future<List<Student>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((e) => Student.fromJson(e)).toList();
  }

  static Future<void> saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = students.map((s) => s.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }
}
