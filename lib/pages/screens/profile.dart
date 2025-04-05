import 'package:bca_student_app/pages/screens/signin.dart';
import 'package:bca_student_app/pages/screens/register.dart';
import 'package:bca_student_app/pages/screens/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String username;
  const ProfileScreen({super.key, required this.email, required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 10),

            // User Name Placeholder
             Text(username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Email Placeholder
            Text(email, style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 10),

            // Sign In Button
            CommonButtonWidget(
              buttonText: "Sign In",
              bottoncolor: Colors.cyanAccent,
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Signin()));
              },
            ),
            const SizedBox(height: 10),

            // Register Button
            CommonButtonWidget(
              buttonText: "Register",
              bottoncolor: Colors.amberAccent,
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Register()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
