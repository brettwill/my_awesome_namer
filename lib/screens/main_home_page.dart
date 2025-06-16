import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/screens/contact.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/doglist.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/user_dog_manager_screen.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatelessWidget {
  final String userName;
  static const List<String> imagePaths = [
    'assets/images/Cosma.png',
    'assets/images/Bella.png',
    'assets/images/Max.png',
    'assets/images/bullterrier.png',
    'assets/images/brutus.png',
  ];

  const MainHomePage({super.key, required this.userName});
  Widget buildIconBox({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildImageLinkRow({
    required BuildContext context,
    required List<String> assetPaths,
    double imageWidth = 150,
    double imageHeight = 150,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: assetPaths.map((path) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Image Tapped'),
                    content: Text('You tapped on ${path.split('/').last}'),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                path,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Drawer buildNavigationDrawer(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color(0xFF1B5E20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainHomePage(userName: userName),
                ),
              );
            },
          ),
          ExpansionTile(
            title: Text('The Dogs'),
            children: [
              ListTile(
                title: Text('All Dogs'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DogListScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Dogs Detail'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DogListScreenEx()),
                  );
                },
              ),
              if (userId != null && userId != '')
                ListTile(
                  title: Text('Select Your Dogs'),
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
            title: Text('Contact'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.pets),
            SizedBox(width: 10),
            Text('The way to happiness - Welcome $userName'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DogListScreenEx()),
              );
            },
          ),
          if (Provider.of<UserProvider>(context).userId == null)
            IconButton(
              icon: Icon(Icons.login),
              tooltip: 'Login',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                );
              },
            )
          else
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Logged out')));
              },
            ),
        ],
      ),

      drawer: buildNavigationDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Animal Happyend',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Give a loving home to a dog in need',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildSectionTitle('Our Dogs'),
            ),
            buildImageLinkRow(
              context: context,
              assetPaths: imagePaths,
              imageWidth: 200,
              imageHeight: 200,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'At Animal Happyend we rescue abandoned dogs and find them new families. Explore our site and discover your new best friend.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
