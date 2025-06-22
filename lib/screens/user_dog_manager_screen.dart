// user_dog_manager_screen.dart
import 'package:flutter/material.dart';
import 'package:namer_app/screens/BaseDogScreen.dart';
import '../models/dog_profile.dart';

class UserDogManagerScreen extends BaseDogScreen {
  const UserDogManagerScreen({Key? key, required String userId})
    : super(key: key, userId: userId);

  @override
  _UserDogManagerScreenState createState() => _UserDogManagerScreenState();
}

class _UserDogManagerScreenState
    extends BaseDogScreenState<UserDogManagerScreen> {
  Set<String> _userDogIds = {};
  bool _initialized = false;

  void _toggleDogAssignment(DogProfile dog, bool isAssigned) async {
    setState(() {
      if (isAssigned) {
        _userDogIds.add(dog.id);
      } else {
        _userDogIds.remove(dog.id);
      }
    });

    if (isAssigned) {
      await assignDogToUser(dog.id);
      _showSnackBar('${dog.name} assigned to user.');
    } else {
      await removeDogFromUser(dog.id);
      _showSnackBar('${dog.name} removed from user.');
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Desired Dogs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'View Selected Dogs',
            onPressed: _showSelectedDogsDialog,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<DogProfile>>>(
        future: loadCombinedData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDogs = snapshot.data!['allDogs']!;
          final userDogs = snapshot.data!['userDogs']!;

          if (!_initialized) {
            _userDogIds = userDogs.map((d) => d.id).toSet();
            _initialized = true;
          }

          return ListView.builder(
            itemCount: allDogs.length,
            itemBuilder: (context, index) {
              final dog = allDogs[index];
              final isAssigned = _userDogIds.contains(dog.id);

              return CheckboxListTile(
                title: Row(
                  children: [
                    if (dog.imageUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          dog.imageUrl,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                    Expanded(child: Text(dog.name)),
                  ],
                ),
                value: isAssigned,
                onChanged: (val) {
                  if (val != null) _toggleDogAssignment(dog, val);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showSelectedDogsDialog() async {
    final allDogs = await allDogsFuture;
    final selectedDogs = allDogs
        .where((dog) => _userDogIds.contains(dog.id))
        .toList();
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Selected Dogs'),
        content: SizedBox(
          width: double.maxFinite,
          child: selectedDogs.isEmpty
              ? const Text('No dogs selected.')
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: selectedDogs.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) =>
                      Text(selectedDogs[index].name),
                ),
        ),
      ),
    );
  }
}
