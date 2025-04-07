import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile.dart';

class SupabaseProfileRepository implements ProfileRepository {
  final SupabaseClient _supabaseClient;

  SupabaseProfileRepository(this._supabaseClient);

  @override
  Future<void> saveProfile(Profile profile) async {
    try {
      await _supabaseClient.from('profiles').insert({
        'id': profile.id,
        'first_name': profile.firstName,
        'last_name': profile.lastName,
        'email': profile.email,
        'phone_number': profile.phoneNumber,
      });
    } catch (e) {
      throw Exception('Failed to save profile: $e');
    }
  }

  @override
  Future<Profile?> getProfile(String id) async {
    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return Profile(
      id: response['id'] as String,
      firstName: response['first_name'] as String,
      lastName: response['last_name'] as String,
      email: response['email'] as String,
      phoneNumber: response['phone_number'] as String?,
    );
  }
}