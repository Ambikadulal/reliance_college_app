
import 'package:bca_student_app/pages/screens/sign_in.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ));
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
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Register()));
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
    );
  }
}

