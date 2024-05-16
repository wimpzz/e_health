import 'package:e_health/screens/main_screen.dart'; // Import your MainScreen here
import 'package:e_health/screens/welcome_google.dart';
import 'package:flutter/material.dart';
import '../firebase_auth_service.dart'; // Ensure you import your FirebaseAuthService here
import 'login_screen.dart';
import 'signup_email.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService =
        FirebaseAuthService(); // Instance of FirebaseAuthService

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the MainScreen when the back arrow is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
        title: Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpEmailScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text('Sign Up Using Email'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await _authService.signInWithGoogle();
                    if (user != null) {
                      // Navigate to the WelcomeScreenGoogle after successful sign-in
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreenGoogle(),
                        ),
                      );
                    } else {
                      // Show error message if user cancels sign-in
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Google sign in canceled.')),
                      );
                    }
                  } catch (e) {
                    // Show error message on failure
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Google sign in failed. Please try again.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text('Sign Up with Google'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
