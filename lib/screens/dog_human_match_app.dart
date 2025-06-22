import 'package:flutter/material.dart';
import 'package:namer_app/router.dart';
import 'package:provider/provider.dart';
import '../business/theme_provider.dart';

class DogHumanMatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Match Your Pet to You',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: themeMode,
      routerConfig: router(),
    );
  }
}
