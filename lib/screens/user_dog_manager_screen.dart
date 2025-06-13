import 'package:flutter/material.dart';
import '../controllers/dog_controller.dart';
import '../models/dog_profile.dart';

class UserDogManagerScreen extends StatefulWidget {
  final String userId;

  const UserDogManagerScreen({required this.userId, super.key});

  @override
  State<UserDogManagerScreen> createState() => _UserDogManagerScreenState();
}

class _UserDogManagerScreenState extends State<UserDogManagerScreen> {
  final DogController _controller = DogController();
  late Future<List<DogProfile>> _allDogsFuture;
  late Future<List<DogProfile>> _userDogsFuture;
  Set<String> _userDogIds = {};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _allDogsFuture = _controller.getAllDogs();
    _userDogsFuture = _controller.getUserDogs(widget.userId);
  }

  void _toggleDogAssignment(DogProfile dog, bool isAssigned) async {
    setState(() {
      if (isAssigned) {
        _userDogIds.add(dog.id);
      } else {
        _userDogIds.remove(dog.id);
      }
    });

    if (isAssigned) {
      await _controller.assignDog(widget.userId, dog.id);
    } else {
      await _controller.removeDog(widget.userId, dog.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage User Dogs')),
      body: FutureBuilder<Map<String, List<DogProfile>>>(
        future: _loadCombinedData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDogs = snapshot.data!['allDogs']!;
          final userDogs = snapshot.data!['userDogs']!;

          // ✅ Only initialize once
          if (!_initialized) {
            _userDogIds = userDogs.map((dog) => dog.id).toSet();
            _initialized = true;
          }

          return ListView.builder(
            itemCount: allDogs.length,
            itemBuilder: (context, index) {
              final dog = allDogs[index];
              final isAssigned = _userDogIds.contains(dog.id);

              return CheckboxListTile(
                title: Text(dog.name),
                value: isAssigned,
                onChanged: (bool? value) {
                  if (value != null) {
                    _toggleDogAssignment(dog, value);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<Map<String, List<DogProfile>>> _loadCombinedData() async {
    final allDogs = await _allDogsFuture;
    final userDogs = await _userDogsFuture;
    return {'allDogs': allDogs, 'userDogs': userDogs};
  }
}
