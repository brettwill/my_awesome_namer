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
  late List<DogProfile> _allDogs;
  Set<String> _userDogIds = {};
  bool _initialized = false;

  Future<List<DogProfile>> get allDogsFuture async =>
      (await loadCombinedData())['allDogs']!;

  void _toggleDogAssignment(DogProfile dog, bool assign) async {
    if (assign) {
      await assignDogToUser(dog.id);
      _userDogIds.add(dog.id);
    } else {
      await removeDogFromUser(dog.id);
      _userDogIds.remove(dog.id);
    }
    setState(() {});
  }

  @override
  void onDogCardTapped(String dogId, bool isAssigned, String dogName) {
    final assign = !isAssigned;
    final dog = _findDogById(dogId);
    if (dog != null) {
      _toggleDogAssignment(dog, assign);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            assign
                ? '${dog.name} assigned to user.'
                : '${dog.name} removed from user.',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  DogProfile? _findDogById(String id) {
    // Searches allDogs for a matching id
    final index = _allDogs.indexWhere((dog) => dog.id == id);
    return index != -1 ? _allDogs[index] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Dogs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
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
          _allDogs = allDogs;
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

              return buildDogProfileCard(
                dog,
                isSelected:
                    isAssigned, // used only for icon state, not card background
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
