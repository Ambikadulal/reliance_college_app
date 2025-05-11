import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData.light();
    final ThemeData darkTheme = ThemeData.dark();

    return Theme(
      data: _isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings"), leading: BackButton()),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (val) {
                  setState(() {
                    _isDarkMode = val;
                  });
                },
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.lock),
              title: Text("Privacy and policy "),
            ),
            const ListTile(
              leading: Icon(Icons.star_rate),
              title: Text("Rate Our App"),
            ),
            const ListTile(
              leading: Icon(Icons.person_add),
              title: Text("Follow Us on social media"),
            ),
          ],
        ),
      ),
    );
  }
}
