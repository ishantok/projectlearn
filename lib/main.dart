import 'package:flutter/material.dart';
import 'package:projectlearn/update_deletePage.dart';
import 'auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appwrite Auth',
      home: AuthPage(),
    );
  }
}
