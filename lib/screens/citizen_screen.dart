import 'package:flutter/material.dart';

class CitizenScreen extends StatelessWidget {
  const CitizenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Citizen Bundle',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/health-bundle.jpg',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Register to receive VAT exemption (if applicable) and a 20% discount on consults and selected medications.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              '20% discounts on consult\n'
              '20% discounts on selected medications\n'
              'VAT exemption (if applicable)',
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              'Discounts will apply once your eligibility is verified. Verification can take up to 2-3 working days.',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              'Getting Started',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              'Term of Use',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              '- This discount program cannot be combined with any other plan or benefits.\n'
              '- If you have an insurance policy linked to your account, your benefits will be used instead.',
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify
            ),
          ],
        ),
      ),
    );
  }
}
