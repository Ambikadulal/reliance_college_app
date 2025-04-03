import 'package:flutter/material.dart';

class StudentInfoListView extends StatelessWidget {
  const StudentInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> students = [
      'Bhupendra Bahadur Shahi',
      'Bibek Poudel',
      'Bishal Tamang',
      'Dipesh Shrestha',
      'Gautam Ghale',
      'Jasmin KC',
      'Karma Bhote',
      'Krinisha Shrestha',
      'Mandip Kafle',
      'Manish Bastakoti',
      'Nutan Kafle',
      'Prabesh Shrestha',
      'Pranaya Shrestha',
      'Prashant Giri',
      'Pratik Khadka',
      'Pukar Rai',
      'Roshan Gurung',
      'Siddhantha Khanal',
      'Sudeep Bhattarai',
      'Sushil Kafle',
      'Tulman Tamang',
    ];

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                219,
                221,
                223,
              ), // Light blue background color
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 184, 156, 226),
                child: Text('${index + 1}'),
              ),
              title: Text(
                students[index],
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Roll No of ${students[index]} is ${index + 1} ',
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
