import 'package:bca_student_app/pages/screens/register_screen.dart';
import 'package:bca_student_app/pages/screens/sign_in.dart';
import 'package:bca_student_app/pages/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
  });

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.setBool('isLoggedIn', false);

    // Optional: Navigate to login page or show confirmation
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Signin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = email.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username.isNotEmpty ? username : "Welcome!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  CommonButtonWidget(
                    buttonText: "Logout",
                    onPressed: () => _logout(context),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Guest User",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonButtonWidget(
                    buttonText: "Sign In",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signin(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CommonButtonWidget(
                    buttonText: "Register",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
