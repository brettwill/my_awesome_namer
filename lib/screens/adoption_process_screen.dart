import 'package:flutter/material.dart';
import 'contact.dart';

class AdoptionProcessScreen extends StatelessWidget {
  const AdoptionProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Process'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/process_icon.png', height: 100),
            const SizedBox(height: 16),
            const Text(
              'Interested in one of our dogs?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you are interested in adopting one of our dogs, please first fill out the questionnaire and send it to us using the online form on this page. If there are multiple applicants, we will choose in the best interest of the dog, not based on order of application.',
            ),
            const SizedBox(height: 16),
            const Text(
              'At our shelters, the dogs are neutered, microchipped, vaccinated, and receive veterinary care. If you decide to adopt and are willing to pay the adoption fee of CHF 850.- (fees may vary for external adoptions) and agree to a home visit, then please complete the following questionnaire.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Steps in the process:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Step 1 with link to ContactPage
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactPage()),
                );
              },
              child: const Text(
                '1. Go to the contact form',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Text('2. Send the form to us'),
            const Text('3. Home check will be arranged'),
            const Text('4. Dog transportation arranged'),
            const Text('5. Follow-up visit'),
            const SizedBox(height: 16),
            const Text(
              'Give-Away Bags:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Every adopter will receive a GIVE-AWAY-BAG upon picking up their dog at the Wädenswil/Beichlen transport arrival location from animal-happyend.',
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactPage()),
                );
              },
              child: const Text('Thank you for your trust!'),
            ),
          ],
        ),
      ),
    );
  }
}
