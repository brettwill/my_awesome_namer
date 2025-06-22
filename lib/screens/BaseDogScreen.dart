import 'package:flutter/material.dart';
import '../controllers/dog_controller.dart';
import '../models/dog_profile.dart';
import '../helpers/dog_profile_card.dart';

abstract class BaseDogScreen extends StatefulWidget {
  final String userId;
  const BaseDogScreen({Key? key, required this.userId}) : super(key: key);
}

abstract class BaseDogScreenState<T extends BaseDogScreen> extends State<T> {
  final DogController _controller = DogController();
  late Future<List<DogProfile>> _allDogsFuture;
  late Future<List<DogProfile>> _userDogsFuture;

  /// Protected getter for userDogsFuture
  Future<List<DogProfile>> get userDogsFuture => _userDogsFuture;

  DogController get controller => _controller;

  @override
  void initState() {
    super.initState();
    _allDogsFuture = _controller.getAllDogs();
    _userDogsFuture = _controller.getUserDogs(widget.userId);
  }

  Future<void> refreshDogs() async {
    setState(() {
      _allDogsFuture = _controller.getAllDogs();
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  Future<void> assignDogToUser(String dogId) async {
    await _controller.assignDog(widget.userId, dogId);
    setState(() {
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  /// NEW: Remove dog from user helper
  Future<void> removeDogFromUser(String dogId) async {
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
