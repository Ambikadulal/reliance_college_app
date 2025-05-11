import 'package:bca_student_app/pages/screens/register.dart';
import 'package:bca_student_app/pages/screens/signin.dart';
import 'package:bca_student_app/pages/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required String email,
    required String username,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "";
      _email = prefs.getString('email') ?? "";
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    setState(() {
      _username = "";
      _email = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = _email.isNotEmpty;

    return Scaffold(
      body: Container(
        color: Colors.green[100],
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 250,
                child: Lottie.asset(
                  'assets/profile.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    isLoggedIn
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
                              _username.isNotEmpty ? _username : "Welcome!",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _email,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            CommonButtonWidget(
                              buttonText: "Logout",
                              onPressed: _logout,
                              bottoncolor: Colors.blue,
                              textColor: Colors.white,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signin(),
                                  ),
                                );
                              },
                              bottoncolor: Colors.green,
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            CommonButtonWidget(
                              buttonText: "Register",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                              bottoncolor: Colors.lightGreenAccent,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
