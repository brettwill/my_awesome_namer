import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/screens/contact.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/doglist.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/upload_image_screen.dart';
import 'package:provider/provider.dart';

class HundeSuchePage extends StatelessWidget {
  final String userName;
  static const List<String> imagePaths = [
    'assets/images/Cosma.png',
    'assets/images/Bella.png',
    'assets/images/Max.png',
    'assets/images/bullterrier.png',
  ];

  const HundeSuchePage({super.key, required this.userName});
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

  Widget buildSocialMediaBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
        IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        IconButton(icon: Icon(Icons.play_circle_fill), onPressed: () {}),
      ],
    );
  }

  Drawer buildNavigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              'Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HundeSuchePage(userName: userName),
                ),
              );
            },
          ),
          ExpansionTile(
            title: Text('Über uns'),
            children: [
              ListTile(title: Text('Geschichte'), onTap: () {}),
              ListTile(title: Text('Unsere Mission'), onTap: () {}),
              ListTile(title: Text('Team'), onTap: () {}),
            ],
          ),
          ListTile(
            title: Text('Dogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DogListScreen()),
              );
            },
          ),
          ListTile(
            title: Text('DogsDetail'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DogListScreenEx()),
              );
            },
          ),
          ListTile(
            title: Text('Contact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KontaktPage()),
              );
            },
          ),
          ListTile(
            title: Text('Upload Dogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadImageScreen()),
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
            onPressed: () {
              // Add search functionality here
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildImageLinkRow(
              context: context,
              assetPaths: imagePaths,
              imageWidth: 300,
              imageHeight: 300,
            ),
            buildSocialMediaBar(),
          ],
        ),
      ),
    );
  }
}
