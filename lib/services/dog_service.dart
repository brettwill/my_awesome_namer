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

  Future<List<DogProfile>> fetchDogsWithFilter({
    Map<String, String>? filters,
  }) async {
    var query = _client.from('dogs').select();

    filters?.forEach((key, value) {
      if (value.isNotEmpty) {
        query = query.ilike(key, '%$value%');
      }
    });

    final response = await query.order('name', ascending: true);
    return (response as List).map((json) => DogProfile.fromJson(json)).toList();
  }

  Future<void> insertDog(DogProfile dog) async {
    await _client.from('dogs').insert(dog.toMap());
  }

  Future<void> updateDog(DogProfile dog) async {
    await _client.from('dogs').update(dog.toMap()).eq('id', dog.id);
  }

  Future<List<DogProfile>> fetchDogsPaginated(int from, int limit) async {
    final response = await _client
        .from('dogs')
        .select()
        .range(from, from + limit - 1);
    return (response as List)
        .map((e) => DogProfile.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> fetchBreeds() async {
    final response = await _client
        .from('breeds')
        .select('name')
        .order('name', ascending: true);

    return (response as List).map((e) => e['name'] as String).toList();
  }

  /// 🔐 Authenticate user by username and password
  Future<bool> authenticateUser(String username, String password) async {
    final response = await _client
        .from('users')
        .select('id') // Lightweight field
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    return response != null && response is List && response.isNotEmpty;
  }

  Future<String?> authenticateUserGetId(
    String username,
    String password,
  ) async {
    final response = await _client
        .from('users')
        .select('id')
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    if (response != null && response is List && response.isNotEmpty) {
      return response[0]['id'] as String?;
    }

    return null;
  }

  Future<Map<String, dynamic>?> authenticateUserGetIdAdmin(
    String username,
    String password,
  ) async {
    final response = await _client
        .from('users')
        .select('id, isAdmin')
        .ilike('username', username)
        .eq('password', password)
        .limit(1);

    if (response != null && response is List && response.isNotEmpty) {
      final user = response[0] as Map<String, dynamic>;
      return {
        'id': user['id'] as String?,
        'isAdmin': user['isAdmin'] as bool? ?? false,
      };
    }

    return null;
  }
}
