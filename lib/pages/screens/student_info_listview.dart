import 'package:flutter/material.dart';

class StudentInfoListView extends StatelessWidget {
  const StudentInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(
      10,
      (index) => 'Item ${index + 1}',
    );

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            subtitle: Text('This is a description'),
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
