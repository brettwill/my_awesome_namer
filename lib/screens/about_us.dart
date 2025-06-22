import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: const [
                  Icon(Icons.info_outline, size: 80, color: Colors.teal),
                  SizedBox(height: 10),
                  Text(
                    'The way to happeness',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'An organization for dogs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Mission
            const Text(
              'Our Mission',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are committed to rescuing dogs from foreign shelters, providing medical care, and placing them in loving homes. '
              'Each dog is vaccinated, chipped, and spayed or neutered before adoption.',
            ),

            const SizedBox(height: 30),

            // Team
            const Text(
              'Our Team',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are a group of passionate volunteers based in Switzerland, working with international partners to save and rehome dogs. '
              'Our team includes veterinarians, transporters, and caring adopters.',
            ),

            const SizedBox(height: 30),

            // Contact
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Email: '),
            const Text('Phone: +41 23455'),
            const Text('Website: www.myweb.ch'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
