import 'package:bca_student_app/pages/screens/bottom_nav/profile.dart';
import 'package:bca_student_app/pages/screens/profile_register/sign.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;

  final Color navyBlue = const Color(0xFF001F54);

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

  final _formkey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)*|"
        r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b'
        r'\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]'
        r'(?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}'
        r'(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08'
        r'\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
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
                  color: navyBlue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the user name *';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_2_rounded, color: navyBlue),
                  hintText: "Username",
                  hintStyle: TextStyle(color: navyBlue),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: navyBlue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return validateEmail(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined, color: navyBlue),
                  hintText: "Email",
                  hintStyle: TextStyle(color: navyBlue),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: navyBlue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) => validatePassword(value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open_outlined, color: navyBlue),
                  hintText: "Password",
                  hintStyle: TextStyle(color: navyBlue),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: navyBlue),
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
                  Text(
                    "Register account",
                    style: TextStyle(
                      fontSize: 26,
                      color: navyBlue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              email: _emailController.text,
                              username: _usernameController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: navyBlue,
                        child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
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
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: navyBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 18,
                        color: navyBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
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
