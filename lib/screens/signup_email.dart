import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../firebase_auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUpEmailScreen extends StatelessWidget {
  const SignUpEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up (Email)',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final _authService = FirebaseAuthService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
          content: SingleChildScrollView(
            child: Text(
              'By using this app, you agree to the following terms and conditions:\n\n'
              'You will not use this app for any illegal or unauthorized purpose.\n'
              'You will not attempt to gain unauthorized access to any part of the app.\n'
              'You will not use the app to harass, abuse, or harm others.\n'
              'You will be solely responsible for any consequences that arise from your use of the app.\n\n'
              'These terms and conditions may be subject to change without notice.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
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

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: SingleChildScrollView(
            child: Text(
              'Our Privacy Policy explains how we collect, use, and protect your personal information when you use our app.\n\n'
              '1. Information Collection and Use:\n'
              'We collect information you provide when you register an account, use our services, or contact us.\n\n'
              '2. Information Sharing:\n'
              'We do not share your personal information with third parties except as described in this Privacy Policy.\n\n'
              '3. Data Security:\n'
              'We take appropriate measures to protect your personal information from unauthorized access or disclosure.\n\n'
              '4. Changes to This Privacy Policy:\n'
              'We may update our Privacy Policy from time to time. You are advised to review this Privacy Policy periodically for any changes.\n\n'
              'By using our app, you agree to the collection and use of information in accordance with this Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
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

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.teal),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.teal),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.teal),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: inputDecoration.copyWith(labelText: 'First Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _lastNameController,
            decoration: inputDecoration.copyWith(labelText: 'Last Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _usernameController,
            decoration: inputDecoration.copyWith(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              if (value.length < 3) {
                return 'Username must be at least 3 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _phoneNumberController,
            decoration: inputDecoration.copyWith(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _birthdateController,
            decoration: inputDecoration.copyWith(labelText: 'Birthdate'),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your birthdate';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _sexController,
            decoration: inputDecoration.copyWith(labelText: 'Sex'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your sex';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: inputDecoration.copyWith(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: inputDecoration.copyWith(
              labelText: 'Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: inputDecoration.copyWith(
              labelText: 'Confirm Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                child: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: _acceptTerms,
                onChanged: (bool? value) {
                  setState(() {
                    _acceptTerms = value!;
                  });
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'By using E-Health Anywhere, you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(color: Colors.teal),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _showTermsAndConditionsDialog(context);
                          },
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: Colors.teal),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _showPrivacyPolicyDialog(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && _acceptTerms) {
                  try {
                    await _authService.signUpWithEmailPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _firstNameController.text.trim(),
                      _lastNameController.text.trim(),
                      _usernameController.text.trim(),
                      _phoneNumberController.text.trim(),
                      _birthdateController.text.trim(),
                      _sexController.text.trim(),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          email: _emailController.text.trim(),
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          userName: _usernameController.text.trim(),
                          phoneNumber: _phoneNumberController.text.trim(),
                          birthdate: _birthdateController.text.trim(),
                          sex: _sexController.text.trim(),
                        ),
                      ),
                    );
                  } catch (_) {
                    _showAlertDialog(context, 'Sign Up Failed',
                        'Sign up failed. Please try again.');
                  }
                } else if (!_acceptTerms) {
                  _showAlertDialog(context, 'Sign Up Failed',
                      'You must accept the terms and conditions to sign up.');
                }
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.teal,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Log In',
                    style: TextStyle(
                      color: Colors.teal,
                      fontFamily: 'Poppins',
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
