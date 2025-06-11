import 'package:flutter/material.dart';
import 'package:namer_app/models/dog.dart';

class DogListItem extends StatelessWidget {
  final Dog dog;
  final VoidCallback onTap;

  const DogListItem({required this.dog, required this.onTap, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(dog.name),
        subtitle: Text(dog.breed ?? 'Unknown breed'),
        onTap: onTap,
      ),
    );
  }
}
