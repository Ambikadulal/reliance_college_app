import 'package:bca_student_app/pages/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text.trim());
    await prefs.setString('email', emailController.text.trim());

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('User data saved locally!')));

    // You can navigate 
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const Signin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "Create Account",
              style: TextStyle(
                fontSize: 30,
                color: Colors.green[400],
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 35),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_rounded,
                  color: Colors.yellow[300],
                ),
                hintText: "Username",
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.yellow[300],
                ),
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: Colors.yellow[300],
                ),
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Register account",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                InkWell(
                  onTap: _saveUserData,
                  child: ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(color: Colors.blue[300]),
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "Already have an account ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Signin()),
                    );
                  },
                  child: const Text(
                    "signin",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}