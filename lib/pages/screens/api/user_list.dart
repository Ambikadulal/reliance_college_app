import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen>
    with TickerProviderStateMixin {
  late Future<List<User>> _futureUsers;
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _animations = [];

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
      final users = decoded.map((e) => User.fromJson(e)).toList();

      for (int i = 0; i < users.length; i++) {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );
        final animation = Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        );

        _controllers.add(controller);
        _animations.add(animation);

        Future.delayed(Duration(milliseconds: i * 100), () {
          if (mounted) _controllers[i].forward();
        });
      }

      return users;
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _addUserToLocal(User user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existing = prefs.getStringList('added_users') ?? [];

    String encodedUser = jsonEncode({
      'id': user.id,
      'name': user.name,
      'email': user.email,
    });

    if (!existing.contains(encodedUser)) {
      existing.add(encodedUser);
      await prefs.setStringList('added_users', existing);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${user.name} added successfully!')),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${user.name} is already added.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        backgroundColor: const Color.fromARGB(255, 158, 133, 202),
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                '/animation/loading.json',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No users found",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final users = snapshot.data!;
          return GridView.builder(
            itemCount: users.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3.5,
              mainAxisSpacing: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemBuilder: (context, index) {
              final user = users[index];
              return SlideTransition(
                position: _animations[index],
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 211, 179, 255),
                          Color.fromARGB(255, 245, 233, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: const TextStyle(color: Colors.black87),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text(
                          user.id.toString(),
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          _addUserToLocal(user);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
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

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email']);
}
