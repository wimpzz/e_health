import 'package:flutter/material.dart';
import '../firebase_auth_service.dart';
import 'login_screen.dart';

class WelcomeScreenEmail extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;

  const WelcomeScreenEmail({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _authService = FirebaseAuthService();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to E-Health',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'First Name: $firstName',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Last Name: $lastName',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authService.signOut(); // Call signOut method
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
