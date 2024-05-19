import 'package:flutter/material.dart';
import 'navbar.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool _isUpcomingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Activity',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isUpcomingSelected = true;
                    });
                  },
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                      fontWeight: _isUpcomingSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _isUpcomingSelected ? Colors.teal : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isUpcomingSelected = false;
                    });
                  },
                  child: Text(
                    'Past',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                      fontWeight: _isUpcomingSelected
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: _isUpcomingSelected ? Colors.black : Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isUpcomingSelected
                  ? _buildUpcomingActivities()
                  : _buildPastActivities(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: 1,
        email: '',
        userName: '',
        firstName: '',
        lastName: '',
      ),
    );
  }

  Widget _buildUpcomingActivities() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_month_rounded,
          size: 150,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          'No Upcoming Appointments Yet',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Schedule your Healthcare appointments at your convenience.',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            //func
          },
          child: Text('Book an Appointment'),
        ),
      ],
    );
  }

  Widget _buildPastActivities() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 150,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          'No Past Appointments Yet',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Ready to explore DA offering? Discover our products & services.',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            //func
          },
          child: Text('Discover'),
        ),
      ],
    );
  }
}
