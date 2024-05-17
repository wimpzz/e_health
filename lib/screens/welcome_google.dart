import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_health/firebase_auth_service.dart';
import 'login_screen.dart';

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

  void _showUserDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          constraints: BoxConstraints(maxHeight: 200), // Set maximum height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_photoURL != null)
                CircleAvatar(backgroundImage: NetworkImage(_photoURL!)),
              if (_displayName != null) Text('Name: $_displayName'),
              if (_email != null) Text('Email: $_email'),
              ElevatedButton(
                onPressed: () => _signOut(context),
                child: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                30.0, 50.0, 30.0, 0), // Adjusted padding
            child: Text(
              'Welcome to E-Health',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      // Handle GP Now card tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.medical_services,
                              size: 40, color: Colors.blue),
                          SizedBox(height: 10),
                          Text('See a GP Now',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      // Handle Book an appointment card tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 40, color: Colors.blue),
                          SizedBox(height: 10),
                          Text('Book an appointment',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Virtual Consultation',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 100, // Adjusted height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SlidingCard(
                      title: 'General Practitioner',
                      icon: Icons.medical_services),
                  SlidingCard(title: 'Specialist', icon: Icons.local_hospital),
                  SlidingCard(title: 'Mental Health', icon: Icons.psychology),
                  SlidingCard(title: 'Surgeon', icon: Icons.local_hospital),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDetails(context),
        tooltip: 'User Details',
        child: Icon(Icons.account_circle),
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String title;
  final IconData icon;

  SlidingCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Adjusted font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
