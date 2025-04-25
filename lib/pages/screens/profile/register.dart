import 'package:bca_student_app/pages/screens/profile/signin.dart';
import 'package:bca_student_app/pages/screens/student_info_listview.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveUserData() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are required!')));
      return;
    }

    try {
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
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern =
          r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formKey, // Associate the key with this form
        child: Column(
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
            // Username field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
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
            // Email field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail, // Use your email validation function
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
            // Password field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
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
                    onTap: () {
                      // Validate form fields before saving user data
                      if (_formKey.currentState!.validate()) {
                        _saveUserData();
                      }
                    },
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
      ),
    );
  }
}
