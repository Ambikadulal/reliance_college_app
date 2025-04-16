import 'package:bca_student_app/pages/screens/signin.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                    ).hasMatch(value)) {
                      return 'Password must be at least 6 characters, including a letter and a number';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Register Account",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle registration logic
                        }
                      },
                      child: ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(color: Colors.blue[300]),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
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
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}