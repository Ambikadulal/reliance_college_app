import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  bool _isDarkMode = false; // Default is light mode
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  String _selectedSortOption = 'Name';

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _futureUsers = fetchUsers();
    _initializeNotifications();
  }

  // Fetch users from API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      final users = decoded.map((e) => User.fromJson(e)).toList();

      // Animation setup for each user
      for (int i = 0; i < users.length; i++) {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );
        final animation = Tween<Offset>(begin: Offset(i % 2 == 0 ? -1.0 : 1.0, 0.0), end: Offset.zero)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

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

  // Initialize local notifications
  void _initializeNotifications() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  // Show notification
  void _showNotification(String title, String body) {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'user_channel', 'User Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    _flutterLocalNotificationsPlugin!.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // Load theme preference
  _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference
  _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  // Toggle Day/Night mode
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _saveThemePreference(_isDarkMode);
    });
  }

  // Sort users based on selected option
  List<User> _sortUsers(List<User> users) {
    switch (_selectedSortOption) {
      case 'Name':
        users.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Email':
        users.sort((a, b) => a.email.compareTo(b.email));
        break;
      default:
        break;
    }
    return users;
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
          backgroundColor: const Color.fromARGB(255, 4, 71, 137),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
            ),
            PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  _selectedSortOption = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return ['Name', 'Email'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        body: FutureBuilder<List<User>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_usmfx6bp.json',
                  width: 150,
                  height: 150,
                  repeat: true,
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

            final users = _sortUsers(snapshot.data!);
            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                final user = users[index];
                return SlideTransition(
                  position: _animations[index],
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF001F3F), // Navy blue
                            Colors.white,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            user.id.toString(),
                            style: const TextStyle(
                              color: Color(0xFF001F3F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onTap: () {
                          // Show notification when user is tapped
                          _showNotification('User Selected', '${user.name}');
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
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
