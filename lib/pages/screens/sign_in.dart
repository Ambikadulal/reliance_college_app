import 'package:bca_student_app/pages/screens/my_home_page.dart';
import 'package:bca_student_app/pages/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"
        r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\'
        r'[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?';
    final regex = RegExp(pattern);
    return value == null || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? value) {
    return value == null || value.length < 6
        ? 'Password must be at least 6 characters'
        : null;
  }

  Future<void> _signIn() async {
    final prefs = await SharedPreferences.getInstance();

    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    // Here you would normally authenticate with a backend.
    // We're faking it by accepting any valid email/password pair:
    if (email.isNotEmpty && password.isNotEmpty) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);
      await prefs.setString('username', 'John Doe'); // Replace with real name

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Student App'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          children: [
            const SizedBox(height: 40),
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 30,
                color: Colors.pink[400],
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _emailController,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
              ],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: Colors.yellow[300]),
                hintText: "Email address",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _passwordController,
              validator: validatePassword,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.yellow[300]),
                hintText: "Password",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _signIn();
                    }
                  },
                  child: ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.blue[300],
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const Register()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
