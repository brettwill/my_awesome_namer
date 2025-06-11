import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/router.dart'; // Assuming your router is defined here

class DogHumanMatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Match Your Pet to You',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      routerConfig: router(),
    );
  }
}
