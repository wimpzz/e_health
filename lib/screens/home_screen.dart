import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_health/firebase_auth_service.dart';
import 'login_screen.dart';
import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  final String email;
  final String userName;
  final String firstName;
  final String lastName;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthService _authService = FirebaseAuthService();

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
        MaterialPageRoute(builder: (context) => LoginScreen()),
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
              // if (_photoURL != null)
              //   CircleAvatar(backgroundImage: NetworkImage(_photoURL!)),
              CircleAvatar(
                backgroundImage: _photoURL != null
                    ? NetworkImage(_photoURL!)
                    : null,
                child: _photoURL == null ? Icon(Icons.account_circle) : null,
              ),
              Text('First Name: ${widget.firstName}'), // Display the first name
              if (_displayName != null) Text('Display Name: $_displayName'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), // Add some space from the top
            Text(
              'Welcome to E-Health',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // Handle GP Now card tap
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.medical_services, size: 50),
                              SizedBox(height: 10),
                              Text('See a GP Now',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some space between the cards
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // Handle Book an appointment card tap
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 50),
                              SizedBox(height: 10),
                              Text('Book an appointment',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Virtual Consultant',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.arrow_forward), // Arrow icon
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildConsultantCard('General Practitioner', Icons.person),
                  _buildConsultantCard('Specialist', Icons.person_search),
                  _buildConsultantCard('Mental Health', Icons.psychology),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Membership and Health Plan',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Premium Health Plan',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Get the best health care services.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                          'https://via.placeholder.com/150', // Placeholder image URL
                          height: 10, // Set the height of the image
                          fit: BoxFit.cover), // Set the fit of the image
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button tap
                          },
                          child: Text('Join Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDetails(context),
        tooltip: 'User Details',
        child: Icon(Icons.account_circle),
      ),
      bottomNavigationBar: NavBar(), // Add the NavBar widget here
    );
  }

  Widget _buildConsultantCard(String title, IconData icon) {
    return Card(
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
