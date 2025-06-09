import 'package:flutter/material.dart';
import 'package:namer_app/screens/contact.dart';
import 'package:namer_app/screens/doglist';
import 'package:namer_app/screens/login.dart';

// void main() {
//   runApp(AnimalHappyendApp());
// }

class AnimalHappyendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Happyend',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      home: HundeSuchePage(),
    );
  }
}

class HundeSuchePage extends StatelessWidget {
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

  Widget buildBrowserWarning() {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Sie verwenden einen veralteten Internet Explorer 11 Webbrowser.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Die Inhalte können nicht korrekt dargestellt werden.\nBitte installieren Sie eine aktuellere und sicherere Version.',
            style: TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Download: https://www.microsoft.com/de-de/edge/',
              style: TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
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
            title: Text('Contact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KontaktPage()),
              );
            },
          ),
          ListTile(title: Text('Projekte'), onTap: () {}),
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
            Text('Animal Happyend'),
          ],
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      drawer: buildNavigationDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildBrowserWarning(),
            buildSocialMediaBar(),
            buildSectionTitle('Hundesuche'),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Alle Hunde',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Notfälle',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Die Vergessenen',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hund des Monats',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hunde in der Schweiz',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hunde im Ausland',
              onTap: () {},
            ),
            buildSectionTitle('Vermittlungsablauf'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Prozess von A bis Z',
              onTap: () {},
            ),
            buildSectionTitle('Hilferufe'),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Übersicht Hilferufe',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hilferufe für Hunde',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hundehütten',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.accessibility_new,
              title: 'Pflegestellen gesucht',
              onTap: () {},
            ),
            buildSectionTitle('Patenhunde'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Patenschaft',
              onTap: () {},
            ),
            buildSectionTitle('Happyends'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Glückliche Hunde',
              onTap: () {},
            ),
            buildSectionTitle('Erfolgreiche Transporte'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Reise in die Schweiz',
              onTap: () {},
            ),
            buildSectionTitle('Erfahrungsberichte'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Hundegeschichten',
              onTap: () {},
            ),
            buildSectionTitle('Augen auf beim Kauf'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Vorsicht',
              onTap: () {},
            ),
            buildSectionTitle('Verstorben'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Regenbogenbrücke',
              onTap: () {},
            ),
            buildSectionTitle('Unsere Vision'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Unsere Mission',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Warum ein Tier aus dem Ausland?',
              onTap: () {},
            ),
            buildSectionTitle('Team'),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Team Leitung',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Vermittlung & Admin',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Telefondienst',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Inserenten online & Hundeverwaltung',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Werbung & Öffentlichkeitsarbeiten',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Fotograf Transportankünfte',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Transporthelfer',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Vor- und Nachkontrollen',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Tierärzte',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Botschafter',
              onTap: () {},
            ),
            buildSectionTitle('Unterstützte Stationen'),
            buildIconBox(
              icon: Icons.folder_open,
              title: 'Unterstützte Tierheime',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Station Ungarn',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Station Spanien',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Besuch vor Ort',
              onTap: () {},
            ),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Trauriger Alltag in Ungarn',
              onTap: () {},
            ),
            buildSectionTitle('Presse'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Reportagen',
              onTap: () {},
            ),
            buildSectionTitle('Interviews & Fernsehbeiträge'),
            buildIconBox(
              icon: Icons.arrow_forward,
              title: 'Gespräche',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
