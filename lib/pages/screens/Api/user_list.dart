import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart'; // Make sure to import Lottie

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/empty.json',
              ), // Lottie animation if no users
            );
          }

          final users = snapshot.data!;
          return Stack(
            children: [
              Positioned.fill(
                child: Lottie.asset(
                  "assets/animations/dot_bg.json",
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                opacity:
                    snapshot.connectionState == ConnectionState.done
                        ? 1.0
                        : 0.0,
                duration: const Duration(milliseconds: 500),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return TweenAnimationBuilder(
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(scale: value, child: child),
                        );
                      },
                      child: Card(
                        color: const Color.fromARGB(233, 226, 229, 231),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                child: Text(user.id.toString()),
                              ),
                            ),
                            Text(user.name),
                            Text(user.email),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    username: json['username'],
  );
}
