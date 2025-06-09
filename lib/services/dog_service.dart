import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dog_profile.dart';

class DogService {
  final _client = Supabase.instance.client;

  Future<List<DogProfile>> fetchDogs() async {
    final response = await _client.from('dogs').select();
    return (response as List)
        .map((e) => DogProfile.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<DogProfile>> fetchDogsPaginated(int from, int limit) async {
    final response = await Supabase.instance.client
        .from('dogs')
        .select()
        .range(from, from + limit - 1);
    return (response as List)
        .map((e) => DogProfile.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
