import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscurePassword = true;

  Future<void> insertRecord() async {
    // Validate email format

    // final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    // if (!emailRegex.hasMatch(email.text)) {

    //   print('Please enter a valid email address');
    //   return; // Exit the function if email is invalid
    // }

    // // Validate password length
    // if (password.text.length < 6) {
    //   print('Password must be at least 6 characters long');
    //   return; // Exit the function if password is too short
    // }

    if (email.text != "" && password.text != "") {
      try {
        String url = "http://10.0.2.2/dbgutbis/insert_record.php";
        var res = await http.post(
          Uri.parse(url),
          body: {
            "email": email.text,
            "password": password.text,
          },
        );
        //print(res);
        var response = jsonDecode(res.body);
        //print(response);
        if (response['success'] == true) {
          debugPrint("Inserted successfully");
        } else {
          debugPrint('something wrong');
        }
      } catch (e) {
        debugPrint(e as String?);
      }
    } else {
      debugPrint('please fill the all fields');
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (_) => const HomeScreen()),
    //   (route) => false,
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 45),
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    // insert the logo
                    'assets/icon/app_logo.png',
                    // Fallback to icon if image is not found
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.restaurant_menu,
                        size: 90,
                        color: Colors.deepOrange,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 48),

                // Email field
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 8),

                // Forgot password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),

                // Login button
                ElevatedButton(
                  onPressed: () {
                    // Validate email and password
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      insertRecord();
                      _navigateToHome();
                    } else {
                      debugPrint('Please fill in all fields');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Social login options
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Or continue with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialLoginButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {},
                    ),
                    _socialLoginButton(
                      icon: Icons.facebook,
                      onPressed: () {},
                    ),
                    _socialLoginButton(
                      icon: Icons.apple,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 32),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
