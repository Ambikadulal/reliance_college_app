// import 'dart:ffi';

// import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/register.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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

      return value!.isNotEmpty && !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "WELCOME BACK",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.pink[400],
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _emailController,
                validator: validateEmail,
                onChanged: (value) {
                  print("_emailController::: ${_emailController.text}");
                },

                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.alternate_email, color: Colors.black),
                    ),
                  ),
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  print("_passwordController::: ${_passwordController.text}");
                },
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.lock, color: Colors.black),
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Please sign in",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => ProfileScreen(
                                  email: _emailController.text,
                                  username: '',
                                ),
                          ),
                        );
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.blue[300]),
                        child: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    "Forgot password",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
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
