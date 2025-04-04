import 'package:flutter/material.dart';

// class StudentInfoListView extends StatelessWidget {
//   const StudentInfoListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> items = List.generate(
//       10,
//       (index) => 'Item ${index + 1}',
//     );

//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           elevation: 2,
//           child: ListTile(
//             leading: CircleAvatar(child: Text('${index + 1}')),
//             title: Text(items[index]),
//             subtitle: Text('This is a description'),
//             trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('${items[index]} tapped!')),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

//// updated student name class with json list
// import 'package:flutter/material.dart';

// Student List Data
final List<Map<String, String>> students = [
  {"id": "1", "name": "Aarav Sharma"},
  {"id": "2", "name": "Vivaan Gupta"},
  {"id": "3", "name": "Reyansh Iyer"},
  {"id": "4", "name": "Aadhya Mehta"},
  {"id": "5", "name": "Diya Verma"},
  {"id": "6", "name": "Kabir Joshi"},
  {"id": "7", "name": "Anaya Reddy"},
  {"id": "8", "name": "Ishaan Pillai"},
  {"id": "9", "name": "Saanvi Nair"},
  {"id": "10", "name": "Rohan Desai"},
];

class StudentInfoListView extends StatelessWidget {
  const StudentInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(child: Text(students[index]["id"]!)),
            title: Text(
              students[index]["name"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Student ID: ${students[index]["id"]}"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${students[index]["name"]} tapped!')),
              );
            },
          ),
        );
      },
    );
  }
}
