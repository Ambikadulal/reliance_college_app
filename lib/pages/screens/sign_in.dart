import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/register_screen.dart';
import 'package:flutter/material.dart';


/// task 
/// 
/// validation onall form fields
/// add sign in button on register screen and send to related screen
/// add register in button on sign screen and send to related screen
/// profile screen should show the email of the user, user name 
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
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "welcome back",
                style: TextStyle(
                  fontSize: 30,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
             
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.email_outlined,
                        color: Colors.yellow[300],
                      ),
                    ),
                  ),
                  hintText: "Email address",
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
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.yellow[300],
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "sign in  ..................",
                  style: TextStyle(
                    fontSize: 14,
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
                              (context) =>
                                  ProfileScreen(email: _emailController.text),
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
            SizedBox(height: 50),
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
