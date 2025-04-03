import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 80,
              color: Color.fromARGB(255, 136, 126, 161),
            ),
            const SizedBox(height: 16),
            Text(
              'Sushil Kafle',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
