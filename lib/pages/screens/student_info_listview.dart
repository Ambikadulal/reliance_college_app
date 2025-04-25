import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final int id;
  String name;

  Student({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Student.fromJson(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name']);
}

class StudentInfoListView extends StatefulWidget {
  const StudentInfoListView({super.key});

  @override
  State<StudentInfoListView> createState() => _StudentInfoListViewState();
}

class _StudentInfoListViewState extends State<StudentInfoListView> {
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isDarkMode = false;
  String searchQuery = '';
  bool isFABPressed = false;

  final customBlue = Color.fromARGB(255, 4, 71, 137);

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('student_list');
    if (data != null) {
      try {
        final List decoded = jsonDecode(data);
        final loadedStudents = decoded.map((e) => Student.fromJson(e)).toList();
        setState(() {
          students = loadedStudents;
          _filterStudents(searchQuery);
        });
      } catch (e) {
        debugPrint("Error loading student data: $e");
      }
    }
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(students.map((s) => s.toJson()).toList());
    await prefs.setString('student_list', encoded);
  }

  void _addStudent(int id, String name) async {
    final newStudent = Student(id: id, name: name);
    setState(() {
      students.add(newStudent);
      _filterStudents(searchQuery);
    });
    await _saveStudents();
  }

  void _deleteStudent(int index) async {
    setState(() {
      students.remove(filteredStudents[index]);
      _filterStudents(searchQuery);
    });
    await _saveStudents();
  }

  void _editStudent(int index, String newName) async {
    final realIndex = students.indexOf(filteredStudents[index]);
    setState(() {
      students[realIndex].name = newName;
      _filterStudents(searchQuery);
    });
    await _saveStudents();
  }

  void _filterStudents(String query) {
    setState(() {
      searchQuery = query;
      filteredStudents = students
          .where(
            (student) =>
                student.name.toLowerCase().contains(query.toLowerCase()) ||
                student.id.toString().contains(query),
          )
          .toList();
    });
  }

  void _showAddStudentDialog() {
    final idController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Student"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "Student ID"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Student Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final id = int.tryParse(idController.text.trim());
              final name = nameController.text.trim();
              if (id != null && name.isNotEmpty) {
                final exists = students.any((s) => s.id == id);
                if (exists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Student ID $id already exists."),
                    ),
                  );
                } else {
                  _addStudent(id, name);
                  Navigator.pop(context);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter valid ID and name")),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(int index) {
    final nameController = TextEditingController(
      text: filteredStudents[index].name,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Student"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "New Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                _editStudent(index, newName);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Student"),
        content: Text(
          "Are you sure you want to delete ${filteredStudents[index].name}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteStudent(index);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Student List"),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search by name or ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _filterStudents,
              ),
            ),
            Expanded(
              child: filteredStudents.isEmpty
                  ? const Center(child: Text("No students found."))
                  : ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 500 + index * 100),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 20),
                                child: child,
                              ),
                            );
                          },
                          child: Card(
                            color: customBlue,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 4,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                  '${student.id}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                student.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                "Student ID: ${student.id}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                              trailing: PopupMenuButton<String>(
                                color: Colors.white,
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditDialog(index);
                                  } else if (value == 'delete') {
                                    _confirmDelete(index);
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.0, end: 1.0),
          duration: Duration(milliseconds: 300),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: FloatingActionButton(
            onPressed: _showAddStudentDialog,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
