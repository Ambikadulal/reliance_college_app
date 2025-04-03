import 'package:flutter/material.dart';

class Student {
  final String name;
  final int age;
  final String id;

  Student({required this.name, required this.age, required this.id});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(name: json['name'], age: json['age'], id: json['id']);
  }
}

class StudentInfoListView extends StatelessWidget {
  const StudentInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final List<String> items = List.generate(
      10,
      (index) => 'Item ${index + 1}',
    );
=======
    // List of students
    final List<Map<String, dynamic>> studentJsonList = [
      {"id": "1", "name": "Bhupendra Bahadur Shahi", "age": 20},
      {"id": "2", "name": "Bibek Poudel", "age": 21},
      {"id": "3", "name": "Bishal Tamang", "age": 22},
      {"id": "4", "name": "Dipesh Shrestha", "age": 23},
      {"id": "5", "name": "Gautam Ghale", "age": 20},
      {"id": "6", "name": "Jasmin KC", "age": 21},
      {"id": "7", "name": "Karma Bhote", "age": 22},
      {"id": "8", "name": "Krinisha Shrestha", "age": 23},
      {"id": "9", "name": "Mandip Kafle", "age": 20},
      {"id": "10", "name": "Manish Bastakoti", "age": 21},
      {"id": "11", "name": "Nutan Kafle", "age": 22},
      {"id": "12", "name": "Prabesh Shrestha", "age": 23},
      {"id": "13", "name": "Pranaya Shrestha", "age": 20},
      {"id": "14", "name": "Prashant Giri", "age": 21},
      {"id": "15", "name": "Pratik Khadka", "age": 22},
      {"id": "16", "name": "Pukar Rai", "age": 23},
      {"id": "17", "name": "Roshan Gurung", "age": 20},
      {"id": "18", "name": "Siddhanta Khanal", "age": 21},
      {"id": "19", "name": "Sudeep Bhattarai", "age": 22},
      {"id": "20", "name": "Sushil Kafle", "age": 23},
      {"id": "21", "name": "Tulman Tamang", "age": 20},
    ];

    final List<Student> students =
        studentJsonList.map((json) => Student.fromJson(json)).toList();
>>>>>>> d16d47e (Added JSON-based student listing in StudentInfoListView)

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];

        return Card(
<<<<<<< HEAD
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
=======
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
>>>>>>> d16d47e (Added JSON-based student listing in StudentInfoListView)
          child: ListTile(
            leading: CircleAvatar(child: Text(student.id)),
            title: Text(student.name),
            subtitle: Text('Age: ${student.age}'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${student.name} tapped!')),
              );
            },
          ),
        );
      },
    );
  }
}
