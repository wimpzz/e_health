import 'package:flutter/material.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen({super.key});

  @override
  _HealthRecordScreenState createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  bool _isUpcomingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Record',
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
                    'Your Records',
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
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isUpcomingSelected = false;
                    });
                  },
                  child: Text(
                    'Upload',
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
            const SizedBox(height: 20),
            Expanded(
              child: _isUpcomingSelected
                  ? _buildUpcomingActivities()
                  : _buildPastActivities(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingActivities() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.health_and_safety_outlined,
          size: 150,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          'You dont have any health records yet.',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'If you do the screening with us, this is where you can check your personalized report later.',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPastActivities() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.upload_outlined,
          size: 150,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        const Text(
          'Upload and store your records',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'Optimize your experience on our app by upoading your health records.',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            //func
          },
          child: const Text('Upload'),
        ),
      ],
    );
  }
}
