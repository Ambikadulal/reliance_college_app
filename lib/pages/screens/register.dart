import 'package:bca_student_app/pages/screens/profile.dart';
import 'package:bca_student_app/pages/screens/signin.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            // Padding(
            //   padding: const EdgeInsets.only(right: 300),
            //   child: Icon(Icons.arrow_back,),
            // ),
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
            SizedBox(height: 35),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the user name *';
                  }
                  return null;
                },
                onChanged: (value) {
                  print("_usernamecontroller::: ${_usernameController.text}");
                },
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.person_2_rounded,
                        color: Colors.yellow[300],
                      ),
                    ),
                  ),
                  hintText: "Username",
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
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter a email';
                  }
                  return null;
                },
                onChanged: (value) {
                  print("_emailController::: ${_emailController.text}");
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
                  hintText: "email",
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
                    return 'please enter password ';
                  }
                  return null;
                },
                onChanged: (value) {
                  print("_passwordcontroller::: ${_passwordController.text}");
                },
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 10,
                    width: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.lock_open_outlined,
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Register account",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => ProfileScreen(
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
                        decoration: BoxDecoration(color: Colors.blue[300]),
                        child: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Already have an account ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => Signin()));
                    },
                    child: Text(
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
