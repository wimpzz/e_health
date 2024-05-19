import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'health_record_screen.dart';
import 'membership.dart';
import 'navbar.dart';
import 'profile_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _displayName;
  String? _photoURL;
  String? _firstName;
  String? _lastName;

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
          _photoURL = user.photoURL;
        });

        if (_displayName == null || _photoURL == null) {
          await _fetchAdditionalUserData(user.uid);
        }
      }
    } catch (e) {
      print('Failed to fetch user info: $e');
    }
  }

  Future<void> _fetchAdditionalUserData(String uid) async {
    try {
      final userDataSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userDataSnapshot.exists) {
        final userData = userDataSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _photoURL = userData['photoURL'];
          _firstName = userData['FirstName'];
          _lastName = userData['LastName'];
          _displayName = '$_firstName $_lastName';
        });
      }
    } catch (e) {
      print('Failed to fetch additional user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'More',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      _photoURL != null ? NetworkImage(_photoURL!) : null,
                  child: _photoURL == null ? Icon(Icons.person) : null,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${_displayName != null ? _displayName! : ''}!',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Text(
                        'View Profile',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.card_membership,
                          color: Colors.teal,
                          size: 50,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Membership & Health Plan',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembershipScreen()),
                              );
                            },
                            child: Text(
                              'See Membership',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'My Health Data',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthRecordScreen()),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Colors.teal,
                        size: 50,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Health Records',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'See Lab Results and more',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
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
      bottomNavigationBar: NavBar(
        currentIndex: 2,
        email: '',
        userName: '',
        firstName: _firstName ?? '',
        lastName: _lastName ?? '',
      ),
    );
  }
}
