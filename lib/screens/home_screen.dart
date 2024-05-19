import 'package:e_health/screens/membership.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required String phoneNumber,
    required String birthdate,
    required String sex,
  });

  final String email;
  final String userName;
  final String firstName;
  final String lastName;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Welcome to E-Health',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          //func
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.medical_services, size: 50),
                              SizedBox(height: 10),
                              Text(
                                'See a GP Now',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Poppins'),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          //func
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 50),
                              SizedBox(height: 10),
                              Text('Book an appointment',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Poppins'),
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
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Virtual Consultant',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
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
            const SizedBox(height: 20),
            const Text(
              'Membership and Health Plan',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: const AssetImage(
                        'assets/sample-health-card.png', 
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8),
                        BlendMode
                            .darken, 
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Link your Corporate Membership',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Or Subscribe to one of our plans to enjoy exclusive benefits.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white, 
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembershipScreen()),
                              );
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: 0,
        email: '',
        userName: '',
        firstName: '',
        lastName: '',
      ), // Add the NavBar widget here
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
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
