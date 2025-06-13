import 'package:flutter/material.dart';
import 'package:namer_app/business/user_provider.dart';
import 'package:provider/provider.dart';

class DogNutritionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //   var appState = context.watch<MyAppState>();

    String? userId = Provider.of<UserProvider>(context).userId;

    // if (appState.favorites.isEmpty) {
    return Center(child: Text(userId!));
    //}
  }
}
