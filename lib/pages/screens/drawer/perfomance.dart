import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  final List<Map<String, dynamic>> subjects = const [
    {'subject': 'dot net ', 'score': 85},
    {'subject': 'computer graphic', 'score': 75},
    {'subject': 'e-learning', 'score': 90},
    {'subject': 'introduction to management ', 'score': 65},
    {'subject': 'networking', 'score': 80},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance"),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject['subject'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: subject['score'] / 100,
                    backgroundColor: Colors.grey[300],
                    color:
                        subject['score'] >= 75 ? Colors.green : Colors.orange,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 5),
                  Text("${subject['score']}%"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
