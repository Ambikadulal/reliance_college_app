import 'package:flutter/material.dart';

class StudentInfoListView extends StatelessWidget {
  const StudentInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Nutan Kafle',
      'Sijan Kafle',
      'Item 3',
      'Item 4'
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            subtitle: Text(index == 0
                ? 'My name is Nutan Kafle from BCA 5th semester. This is my first BCA app.'
                : index == 1
                  ? 'My name is Sijan Kafle from BCA 5th semester. I study in Reliance college.'
                  : 'This is a description'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${items[index]} tapped!')),
              );
            },
          ),
        );
      },
    );
  }
}
