import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/screens/favorites.dart';
import 'package:namer_app/screens/generator.dart';
import 'package:namer_app/screens/nutrition.dart';
import 'package:namer_app/screens/school.dart';

class MyHomePage extends StatefulWidget {
  final String userId;
  const MyHomePage({super.key, required this.userId});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = DogNutritionPage();

      case 1:
        page = FavoritesPage();

      case 2:
        page = DogNutritionPage();

      case 3:
        page = DogSchoolPage();

      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Namer App - Welcome, ${widget.userId}'),
        actions: [
          // "More" menu
          PopupMenuButton<int>(
            onSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 2, child: Text('Dog School')),
              PopupMenuItem(value: 3, child: Text('Nutrition')),
            ],
            child: TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              label: Text('More', style: TextStyle(color: Colors.blue)),
            ),
          ),

          // "Info" menu
          PopupMenuButton<int>(
            onSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('Home')),
              PopupMenuItem(value: 1, child: Text('Favorites')),
            ],
            child: TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              label: Text('Info', style: TextStyle(color: Colors.blue)),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Log out'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                context.go('/login');
              }
            },
          ),
        ],
      ),

      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
    );
  }
}
