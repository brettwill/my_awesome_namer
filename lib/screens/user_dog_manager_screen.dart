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
      _showSnackBar('${dog.name} assigned to user.');
    } else {
      await _controller.removeDog(widget.userId, dog.id);
      _showSnackBar('${dog.name} removed from user.');
    }
  }

  void _showSnackBar(String message) {
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
        future: _loadCombinedData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDogs = snapshot.data!['allDogs']!;
          final userDogs = snapshot.data!['userDogs']!;

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
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                    Expanded(child: Text(dog.name)),
                  ],
                ),
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

  void _showSelectedDogsDialog() async {
    final allDogs = await _allDogsFuture;
    final selectedDogs = allDogs
        .where((dog) => _userDogIds.contains(dog.id))
        .toList();
    if (!mounted) return; // ✅ Prevent using context if widget is disposed

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selected Dogs'),
        content: SizedBox(
          width: double.maxFinite,
          child: selectedDogs.isEmpty
              ? const Text('No dogs selected.')
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: selectedDogs.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final dog = selectedDogs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: dog.imageUrl.isNotEmpty
                                  ? Image.network(
                                      dog.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                                size: 60,
                                              ),
                                    )
                                  : const Icon(Icons.pets, size: 60),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dog.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('${dog.breed} • ${dog.gender}'),
                                  Text('Age: ${dog.age}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            _infoChip('Weight', dog.weight),
                            _infoChip('Height', dog.height),
                            _infoChip('Birth Date', dog.birthDate),
                            _infoChip('Location', dog.location),
                          ],
                        ),
                      ],
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Chip(
      label: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white, // Ensures readability in dark mode
        ),
      ),
      backgroundColor:
          Colors.blueGrey.shade700, // Darker background for contrast
    );
  }

  Future<Map<String, List<DogProfile>>> _loadCombinedData() async {
    final allDogs = await _allDogsFuture;
    final userDogs = await _userDogsFuture;
    allDogs.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return {'allDogs': allDogs, 'userDogs': userDogs};
  }
}
