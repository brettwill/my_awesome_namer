import 'package:flutter/material.dart';
import 'package:namer_app/router.dart'; // Assuming your router is defined here

class DogHumanMatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Match Your Pet to You',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark, // Can be .light, .dark, or .system
      routerConfig: router(),
    );
  }
}
