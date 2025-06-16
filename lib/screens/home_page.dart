import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/screens/contact.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/doglist.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/user_dog_manager_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String userName;
  static const List<String> imagePaths = [
    'assets/images/Cosma.png',
    'assets/images/Bella.png',
    'assets/images/Max.png',
    'assets/images/bullterrier.png',
    'assets/images/brutus.png',
  ];

  const HomePage({super.key, required this.userName});

  Drawer buildNavigationDrawer(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color(0xFF1B5E20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
            title: const Text('The Dogs'),
            children: [
              ListTile(
                title: const Text('All Dogs'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DogListScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Dogs Detail'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DogListScreenEx()),
                  );
                },
              ),
              if (userId != null && userId != '')
                ListTile(
                  title: const Text('Select Your Dogs'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDogManagerScreen(userId: userId),
                      ),
                    );
                  },
                ),
            ],
          ),
          ListTile(
            title: const Text('Contact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildImageRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: imagePaths
            .map(
              (path) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  path,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The way to happiness - Welcome $userName'),
      ),
      drawer: buildNavigationDrawer(context),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/bullterrier.png',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Discover our dogs and find your perfect match.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          buildImageRow(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'We offer a variety of breeds and personalities.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
