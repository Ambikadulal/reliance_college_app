import 'package:bca_student_app/pages/screens/sign_in.dart';
import 'package:bca_student_app/pages/screens/register_screen.dart';
import 'package:bca_student_app/pages/screens/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String username;

  const ProfileScreen({super.key, required this.email, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person, size: 50, color: Colors.blue),
                ),
                const SizedBox(height: 20),

                // Username
                Text(
                  username.isNotEmpty ? username : "Guest User",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Sign In Button
                CommonButtonWidget(
                  buttonText: "Sign In",
                  bottoncolor: Colors.greenAccent,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Signin()));
                  },
                  buttonColor: Colors.cyanAccent,
                ),
                const SizedBox(height: 16),

                // Register Button
                CommonButtonWidget(
                  buttonText: "Register",
                  bottoncolor: Colors.lightGreenAccent,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Register()));
                  },
                  buttonColor: Colors.amberAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
