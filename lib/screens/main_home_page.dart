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
    'assets/images/MAX.png',
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

  Widget buildImageGrid(
      {required BuildContext context,
      required List<String> assetPaths,
      required double maxWidth}) {
    int crossAxisCount = (maxWidth / 200).floor();
    crossAxisCount = crossAxisCount.clamp(2, 4);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: assetPaths.length,
      itemBuilder: (context, index) {
        final path = assetPaths[index];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Image Tapped'),
                  content: Text('You tapped on ${path.split('/').last}'),
                  actions: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        );
      },
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Find your perfect companion',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  buildImageGrid(
                    context: context,
                    assetPaths: imagePaths,
                    maxWidth: constraints.maxWidth,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
