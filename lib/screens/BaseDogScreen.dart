// base_dog_screen.dart
import 'package:flutter/material.dart';
import '../controllers/dog_controller.dart';
import '../models/dog_profile.dart';

abstract class BaseDogScreen extends StatefulWidget {
  final String userId;
  const BaseDogScreen({Key? key, required this.userId}) : super(key: key);
}

abstract class BaseDogScreenState<T extends BaseDogScreen> extends State<T> {
  final DogController _controller = DogController();
  late Future<List<DogProfile>> _allDogsFuture;
  late Future<List<DogProfile>> _userDogsFuture;

  DogController get controller => _controller;
  Future<List<DogProfile>> get allDogsFuture => _allDogsFuture;
  Future<List<DogProfile>> get userDogsFuture => _userDogsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _allDogsFuture = _controller.getAllDogs();
    _userDogsFuture = _controller.getUserDogs(widget.userId);
  }

  Future<void> removeDogFromUser(String dogId) async {
    await _controller.removeDog(widget.userId, dogId);
    setState(() {
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  Future<void> assignDogToUser(String dogId) async {
    await _controller.assignDog(widget.userId, dogId);
    setState(() {
      _userDogsFuture = _controller.getUserDogs(widget.userId);
    });
  }

  Future<Map<String, List<DogProfile>>> loadCombinedData() async {
    final allDogs = await _allDogsFuture;
    final userDogs = await _userDogsFuture;
    return {'allDogs': allDogs, 'userDogs': userDogs};
  }
}
