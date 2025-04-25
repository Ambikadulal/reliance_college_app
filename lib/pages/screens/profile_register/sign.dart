import 'package:bca_student_app/pages/screens/bottom_nav/profile.dart';
import 'package:bca_student_app/pages/screens/profile_register/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailcontroller.text = prefs.getString('email') ?? '';
      _passwordcontroller.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailcontroller.text);
      await prefs.setString('password', _passwordcontroller.text);
    }
    await prefs.setBool('rememberMe', _rememberMe);
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String? validateEmail(String? value) {
    const pattern =
        r"(?:[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)*|"
        r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|'
        r'\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@'
        r"(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
        r"(?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|"
        r"[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|"
        r"[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:"
        r"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|"
        r'\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return value == null || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _clearCredentials();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/welcome', (r) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 223),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 4, 99, 128),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _emailcontroller,
                validator: validateEmail,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(255, 31, 134, 198),
                  ),
                  hintText: "Email address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _passwordcontroller,
                obscureText: _obscurePassword,
                validator: validatePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color.fromARGB(255, 25, 25, 24),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  hintText: "Password",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: const Text("Remember Me"),
              value: _rememberMe,
              onChanged: (v) => setState(() => _rememberMe = v!),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveCredentials();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Signed in successfully!')),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => ProfileScreen(
                              email: _emailcontroller.text,
                              username: '',
                            ),
                          ),
                        );
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: const Color.fromARGB(255, 65, 144, 208),
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const Register()),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 8, 137, 142),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/passwordRecovery'),
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 138, 104, 9),
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
