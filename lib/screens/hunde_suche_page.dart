import 'package:flutter/material.dart';
import 'package:namer_app/screens/contact.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/doglist.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/upload_image_screen.dart';

class HundeSuchePage extends StatelessWidget {
  const HundeSuchePage({super.key});
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

  Widget buildImageLink({
    required String assetPath,
    required VoidCallback onTap,
    double? width,
    double? height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Image.asset(
          assetPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
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
                MaterialPageRoute(builder: (context) => MyLogin()),
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
            Text('The way to happiness'),
          ],
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      drawer: buildNavigationDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            //buildBrowserWarning(),
            buildSocialMediaBar(),
          ],
        ),
      ),
    );
  }
}
