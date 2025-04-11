import 'package:bca_student_app/pages/screens/my_home_page.dart';
import 'package:flutter/material.dart';
// import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/register.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

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
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              "Account Login",
              style: TextStyle(
                fontSize: 32,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) => validateEmail(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Email address",
                    hintStyle: TextStyle(color: Colors.grey[700]),
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
                  obscureText: true,
                  validator: (value) => validatePassword(value),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'please enter your password';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[700]),
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
            const SizedBox(height: 20),
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
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder:
                                (context) => MyHomePage(
                                  title: 'Student App',
                                  email: _emailController.text,
                                  username: 'User Name', // Replace if needed
                                ),
                          ),
                        );
                      }
                    },

                    child: Text(
                      "Sign in",
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Dont have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
