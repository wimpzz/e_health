import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_health/firebase_auth_service.dart';

import 'login_screen.dart'; // Import your FirebaseAuthService file

class WelcomeScreenGoogle extends StatefulWidget {
  const WelcomeScreenGoogle({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreenGoogle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthService _authService =
      FirebaseAuthService(); // Instance of FirebaseAuthService

  String? _displayName;
  String? _email;
  String? _photoURL;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          _displayName = user.displayName;
          _email = user.email;
          _photoURL = user.photoURL;
        });
      }
    } catch (e) {
      print('Failed to fetch user info: $e');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await _authService.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()), // Navigate to login screen
      );
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to E-Health'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_photoURL != null)
              CircleAvatar(backgroundImage: NetworkImage(_photoURL!)),
            if (_displayName != null) Text('Name: $_displayName'),
            if (_email != null) Text('Email: $_email'),
          ],
        ),
      ),
    );
  }
}
