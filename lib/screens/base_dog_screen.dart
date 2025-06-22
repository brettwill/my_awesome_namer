import 'package:flutter/material.dart';
import '../controllers/dog_controller.dart';
import '../models/dog_profile.dart';
import '../helpers/dog_profile_card.dart';
import 'package:namer_app/widgets/dog_filter_tile.dart'; // filter UI

abstract class BaseDogScreen extends StatefulWidget {
  final String userId;
  const BaseDogScreen({Key? key, required this.userId}) : super(key: key);
}

abstract class BaseDogScreenState<T extends BaseDogScreen> extends State<T> {
  Future<List<DogProfile>> get allDogsFuture => _allDogsFuture;

  @override
  void initState() {
    super.initState();
    _allDogsFuture = _controller.getAllDogs();
    _userDogsFuture = _controller.getUserDogs(widget.userId);
  }

  Future<List<DogProfile>> get userDogsFuture => _userDogsFuture;
  final DogController _controller = DogController();
  late Future<List<DogProfile>> _allDogsFuture;
  late Future<List<DogProfile>> _userDogsFuture;

  /// Wraps content with a Scaffold that already contains the filter drawer
  Widget buildScreenScaffold({
    required PreferredSizeWidget appBar,
    required Widget body,
  }) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DogFilterTile(
              filters: _filters,
              breedOptions: _breedOptions,
              onFilterChanged: () => setState(() {}),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  Future<void> refreshDogs() async {
    setState(() {
      _allDogsFuture = _controller.getAllDogs();
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  Future<void> assignDogToUser(String dogId) async {
    if (widget.userId == "00000000-0000-0000-0000-000000000000") return;
    await _controller.assignDog(widget.userId, dogId);
    setState(() {
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  /// NEW: Remove dog from user helper
  Future<void> removeDogFromUser(String dogId) async {
    if (widget.userId == "00000000-0000-0000-0000-000000000000") return;
    await _controller.removeDog(widget.userId, dogId);
    setState(() {
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  Future<Map<String, List<DogProfile>>> loadCombinedData() async {
    final allDogs = await _allDogsFuture;
    final userDogs = await _userDogsFuture;
    return {'allDogs': allDogs, 'userDogs': userDogs};
  }

  // ────────────────────────────────
  // Filtering support (final form using Map<String, String>)
  // ────────────────────────────────
  Map<String, String> _filters = {
    'name': '',
    'breed': '',
    'gender': '',
    'age': '',
    'location': '',
  };
  List<String> _breedOptions = [];

  // void _onFiltersChanged() {
  //   setState(() {});
  // }

  List<DogProfile> applyFilters(List<DogProfile> dogs) {
    return dogs.where((d) {
      if (_filters['breed']!.isNotEmpty && d.breed != _filters['breed'])
        return false;
      if (_filters['gender']!.isNotEmpty && d.gender != _filters['gender'])
        return false;

      if (_filters['age']!.isNotEmpty) {
        final dogAge = int.tryParse(d.age);
        final filterAge = int.tryParse(_filters['age']!);
        if (dogAge == null || filterAge == null || dogAge != filterAge)
          return false;
      }

      if (_filters['name']!.isNotEmpty &&
          !d.name.toLowerCase().contains(_filters['name']!.toLowerCase()))
        return false;

      if (_filters['location']!.isNotEmpty &&
          !d.location.toLowerCase().contains(
            _filters['location']!.toLowerCase(),
          ))
        return false;

      return true;
    }).toList();
  }

  /// Abstract method to be implemented by derived classes
  /// to handle tap events on dog cards.
  void onDogCardTapped(String dogId, bool isAssigned, String dogName);

  /// Shared builder for displaying a dog using [DogProfileCard].
  Widget buildDogProfileCard(DogProfile dog, {bool isSelected = false}) {
    return DogProfileCard(
      name: dog.name,
      imageUrl: dog.imageUrl,
      profileUrl: dog.profileUrl,
      birthDate: dog.birthDate,
      age: dog.age,
      breed: dog.breed,
      gender: dog.gender,
      weight: dog.weight,
      height: dog.height,
      location: dog.location,
      isSelected: isSelected,
      onTap: () => onDogCardTapped(dog.id, isSelected, dog.name),
    );
  }
}
