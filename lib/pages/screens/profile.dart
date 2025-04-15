import 'package:bca_student_app/pages/screens/signin.dart';
import 'package:bca_student_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "";

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? "";
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    setState(() {
      email = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.person, size: 50, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text(
                email.isNotEmpty ? email : 'Guest User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CommonButtonWidget(
                buttonText: "Sign In",
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signin()),
                    ),
                bottoncolor: Colors.blue,
              ),
              const SizedBox(height: 10),
              CommonButtonWidget(
                buttonText: "Register",
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signin()),
                    ),
                bottoncolor: Colors.blueGrey,
              ),
              const SizedBox(height: 10),
              CommonButtonWidget(
                buttonText: "Logout",
                onPressed: _logout,
                bottoncolor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
