import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

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
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
      );

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        return decoded.map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("User List"),
        backgroundColor: const Color.fromARGB(214, 208, 177, 255),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/loading.json',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          final users = snapshot.data!;
          return AnimationLimiter(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: const Duration(milliseconds: 600),
                  child: FadeInAnimation(
                    child: SlideAnimation(
                      horizontalOffset: 50,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 132, 75, 217),
                              const Color.fromARGB(255, 163, 102, 248),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                user.id.toString(),
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Email: ${user.email}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Username: ${user.username}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
