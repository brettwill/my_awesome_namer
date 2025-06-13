import 'package:supabase_flutter/supabase_flutter.dart';

class ContactRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> sendContactData({
    required String anrede,
    required String vorname,
    required String name,
    required String email,
    required String telefonnummer,
  }) async {
    try {
      await _client.from('contacts').insert({
        'anrede': anrede,
        'vorname': vorname,
        'name': name,
        'email': email,
        'telefonnummer': telefonnummer,
      });
    } on PostgrestException catch (e) {
      // Handle Supabase-specific errors
      throw Exception('Supabase error: ${e.message}');
    } catch (e) {
      // Handle other errors
      throw Exception('Unexpected error: $e');
    }
  }
}
