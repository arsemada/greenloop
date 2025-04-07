import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart' as DomainUser;

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabaseClient;

  SupabaseAuthRepository(this._supabaseClient);

  @override
  Future<DomainUser.User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'first_name': firstName, 'last_name': lastName, 'phone_number': phoneNumber},
      );
      if (response.user == null) {
        throw Exception('Signup failed: ${response.error?.message ?? 'Unknown error'}');
      }
      return DomainUser.User(
        id: response.user!.id,
        email: response.user!.email!,
        isEmailConfirmed: response.user!.emailConfirmedAt != null,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during signup: $e');
    }
  }

  @override
  Future<DomainUser.User?> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      return null;
    }
    return DomainUser.User(id: user.id, email: user.email!, isEmailConfirmed: user.emailConfirmedAt != null);
  }
}

extension on AuthResponse {
  get error => null;
}