import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dog_profile.dart';

class DogProvider with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  List<DogProfile> _dogs = [];

  List<DogProfile> get dogs => _dogs;

  Future<void> loadDogs() async {
    final response = await _client.from('dogs').select().order('created_at');
    _dogs = (response as List)
        .map((item) => DogProfile.fromMap(item as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> addDog(DogProfile dog) async {
    await _client.from('dogs').insert(dog.toMap());
    await loadDogs();
  }

  Future<void> updateDog(DogProfile dog) async {
    await _client.from('dogs').update(dog.toMap()).eq('id', dog.id);
    await loadDogs();
  }
}
