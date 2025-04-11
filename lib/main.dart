import 'package:bca_student_app/pages/app/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Register Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const RegisterScreen(),
//     );
//   }
// }

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   Future<void> _saveUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', nameController.text);
//     await prefs.setString('email', emailController.text);

//     // Navigate to profile screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const ProfileScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: _saveUserData,
//               child: const Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String? userName;
//   String? email;

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userName = prefs.getString('username');
//       email = prefs.getString('email');
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: userName == null || email == null
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: $userName', style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 16),
//                   Text('Email: $email', style: const TextStyle(fontSize: 18)),
//                 ],
//               ),
//       ),
//     );
//   }
// }
