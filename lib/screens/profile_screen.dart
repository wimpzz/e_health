import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuthService authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: authService.getUserData(currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final userData = snapshot.data!;
        final String email = currentUser?.email ?? '';
        final String fullName =
            '${userData['FirstName']} ${userData['LastName']}';
        final String phoneNumber = userData['PhoneNumber'];
        final String birthDate = userData['BirthDate'];
        final String sex = userData['Sex'];
        final String userName = userData['UserName'];

        String name = fullName.isNotEmpty
            ? fullName
            : email.split('@').first;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '$name !',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                    context,
                    Icons.person,
                    'About Me',
                    fullName.isNotEmpty
                        ? 'Name: $fullName\nSex: $sex\nBirthDate: $birthDate'
                        : 'Name: $userName\nSex: $sex\nBirthDate: $birthDate'),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.email,
                  'Contact Details',
                  'Email: $email\nPhone: $phoneNumber',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.phone,
                  'Emergency Contact Details',
                  'Name: Juan Dela Cruz\nPhone: 09123456789',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.location_on,
                  'Address',
                  '123 Main Street, City, Country',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.payment,
                  'Payment Method',
                  'Credit Card ending in 1234',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.delete,
                  'Delete Account',
                  'Are you sure you want to delete your account?',
                ),
                SizedBox(height: 20),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.language,
                  'Language',
                  'English',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.security,
                  'Login And Security',
                  'Change password and security settings',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.wifi,
                  'Network',
                  'Wi-Fi, Mobile Data',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.library_books,
                  'Legal',
                  'Terms and Conditions, Privacy Policy',
                ),
                SizedBox(height: 20),
                _buildClickableRow(
                  context,
                  Icons.help,
                  'Help and FAQs',
                  'Support and Frequently Asked Questions',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await authService.signOut();
                      // Navigate to login screen after logout
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    } catch (e) {
                      print('Failed to sign out: $e');
                      // Handle sign out failure
                    }
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClickableRow(
      BuildContext context, IconData icon, String title, String content) {
    return GestureDetector(
      onTap: () {
        _showPopupModal(context, title, content);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
