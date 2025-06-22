import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:namer_app/screens/AboutUs.dart';
import 'package:namer_app/screens/adoption_process_screen.dart';
import 'package:namer_app/screens/dog_list_screen.dart';
import 'package:namer_app/screens/favorites_screen.dart';
import 'package:namer_app/screens/login_screen.dart';
import 'package:namer_app/screens/user_dog_manager_screen.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/common/constants.dart';
import '../business/theme_provider.dart';

class MainHomePage extends StatelessWidget {
  final String userName;

  const MainHomePage({super.key, required this.userName});

  Drawer buildNavigationDrawer(BuildContext context) {
    final userId =
        Provider.of<UserProvider>(context).userId ??
        nullGuid;
    final isAdmin = Provider.of<UserProvider>(context).isAdmin;

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
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            title: const Text('All Dogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDogManagerScreen(userId: userId),
                ),
              );
            },
          ),
          /*ExpansionTile(
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
                    MaterialPageRoute(builder: (context) => DogAdminstration()),
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
          ),*/
          ListTile(
            title: const Text('Adoption Process'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdoptionProcessScreen(),
                ),
              );
            },
          ),
          if (userId != nullGuid)
            ListTile(
              title: const Text('My Favourites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritesScreen(userId: userId),
                  ),
                );
              },
            ),
          if (userId != nullGuid && isAdmin)
            ExpansionTile(
              title: const Text('Administraion'),
              children: [
                ListTile(
                  title: const Text('Dog Workbench'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DogAdminstration(),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildFeatureCard(IconData icon, String title, String description) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.teal),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId ?? nullGuid;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(
          0xFF1B5E20,
        ), // This sets the AppBar color to green
        foregroundColor: Color(0xFFFFFFFF),
        title: Row(
          children: [
            const Icon(Icons.pets),
            const SizedBox(width: 10),
            Text('The way to happiness - Welcome $userName'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDogManagerScreen(userId: userId),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          if (userProvider.userId == null)
            IconButton(
              icon: const Icon(Icons.login),
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
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Logged out')));
              },
            ),
        ],
      ),
      drawer: buildNavigationDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ Hero Image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                'assets/images/main_page.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Section: Intro Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: const [
                  Text(
                    'Welcome to Dog World',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Discover the most adorable dogs and choose your best friend. Our platform helps you connect, learn, and love.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth > 600 ? 3 : 1;
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      buildFeatureCard(
                        Icons.favorite,
                        'Adopt',
                        'Find your forever furry friend and bring love home.',
                      ),
                      buildFeatureCard(
                        Icons.pets,
                        'Browse Breeds',
                        'Explore dog breeds and learn what suits you.',
                      ),
                      buildFeatureCard(
                        Icons.location_on,
                        'Find Nearby',
                        'Locate shelters and dog events near you.',
                      ),
                      buildFeatureCard(
                        Icons.event,
                        'Events',
                        'Check upcoming dog shows and adoption drives.',
                      ),
                      buildFeatureCard(
                        Icons.contact_page,
                        'Contact Us',
                        'We are here to help you get started.',
                      ),
                      buildFeatureCard(
                        Icons.info,
                        'About Us',
                        'Learn more about our mission and community.',
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
