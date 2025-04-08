import 'package:bca_student_app/pages/screens/sign_in.dart';
import 'package:bca_student_app/pages/screens/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({super.key, this.email = ""});

  @override
  Widget build(BuildContext context) {
    return
    // appBar:
    //     email != ""
    //         ? AppBar(
    //           title: const Text("Profile"),
    //           backgroundColor: Colors.blue,
    //         )
    //         : null,
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 10),

            // User Name Placeholder
            const Text(
              "Guest User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Email Placeholder
            Text(email, style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),

            // Sign In Button
            CommonButtonWidget(
              buttonText: "Sign In",
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signin()),
                  ),
            ),
            const SizedBox(height: 10),

            // Register Button
            CommonButtonWidget(
              buttonText: "Register",
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signin()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
