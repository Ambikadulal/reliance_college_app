import 'package:bca_student_app/pages/screens/my_home_page.dart';
import 'package:flutter/material.dart';
// import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/signin.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
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

    String? validatePassword(String? value) {
      const pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
      final regex = RegExp(pattern);

      return value == null || !regex.hasMatch(value)
          ? 'Password must be at least 8 characters,\ninclude upper, lower, digit & special char'
          : null;
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 32,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the user name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) => validateEmail(value),
                  //{
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter an email';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) => validatePassword(value),

                  //(value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter password';
                  //   }
                  //   return null;
                  // },
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 40,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (context) => MyHomePage(
                                title: 'Student App',
                                email: _emailController.text,
                                username: _usernameController.text,
                              ),
                        ),
                      );
                    },

                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Signin()),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
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
