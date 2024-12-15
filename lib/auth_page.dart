import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:projectlearn/update_deletePage.dart';
import 'appwrite_provider.dart';
import 'update_delete_page.dart'; // Import UpdateDeletePage

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLogin = true;

  void _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    try {
      if (_isLogin) {
        // Login
        await appwriteProvider.account.createEmailSession(
          email: email,
          password: password,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );

        // Navigate to UpdateDeletePage after successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateDeletePage()),
        );
      } else {
        // Signup
        await appwriteProvider.account.create(
          userId: 'unique()',
          email: email,
          password: password,
          name: name,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful! Please login.')),
        );
        setState(() {
          _isLogin = true; // Switch to login mode after signup
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isLogin) // Show name field only during signup
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleAuth,
              child: Text(_isLogin ? 'Login' : 'Signup'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin
                  ? 'Don\'t have an account? Signup'
                  : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on Account {
  createEmailSession({required String email, required String password}) {}
}
