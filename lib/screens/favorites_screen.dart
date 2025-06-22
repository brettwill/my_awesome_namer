// favourites_screen.dart
import 'package:flutter/material.dart';
import 'package:namer_app/screens/BaseDogScreen.dart';
import '../models/dog_profile.dart';

class FavouritesScreen extends BaseDogScreen {
  const FavouritesScreen({Key? key, required String userId})
    : super(key: key, userId: userId);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends BaseDogScreenState<FavouritesScreen> {
  Future<void> _confirmAndRemove(String dogId, String dogName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Favourite'),
        content: Text(
          'Are you sure you want to remove $dogName from favourites?',
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text('Remove'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await removeDogFromUser(dogId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$dogName removed from favourites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Favourite Dogs')),
      body: FutureBuilder<List<DogProfile>>(
        future: userDogsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dogs = snapshot.data!;
          if (dogs.isEmpty) {
            return const Center(child: Text('You have no favourites yet.'));
          }

          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return ListTile(
                leading: dog.imageUrl.isNotEmpty
                    ? Image.network(
                        dog.imageUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : const Icon(Icons.pets),
                title: Text(dog.name),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _confirmAndRemove(dog.id, dog.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
