import 'package:greenloop/domain/entities/user.dart' as AppUser;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/user_repository.dart';

class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _supabaseClient;

  SupabaseUserRepository(this._supabaseClient);

  @override
  Future<AppUser.User?> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      return null;
    }
    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    return response == null ? AppUser.User(id: user.id, email: user.email) : AppUser.User.fromJson(response..addAll({'id': user.id, 'email': user.email}));
  }

  @override
  Future<AppUser.User?> getUserProfile(String id) async {
    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', id)
        .maybeSingle();
    final authUser = await _supabaseClient.auth.getUser(id);
    return response == null ? AppUser.User(id: id, email: authUser.user?.email) : AppUser.User.fromJson(response..addAll({'id': id, 'email': authUser.user?.email}));
  }

  @override
  Future<String> signUp({
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
      if (response.user?.id == null) {
        // Signup failed, check for errors in response (though try-catch should handle)
        throw Exception('Signup failed');
      }
      // Create a profile entry after successful signup
      final profileInsertResponse = await _supabaseClient.from('profiles').insert({
        'id': response.user!.id,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
      }).select('id').single();

      if (profileInsertResponse == null) {
        throw Exception('Failed to insert profile data.');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during signup: $e');
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String otp}) async {
    try {
      await _supabaseClient.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during OTP verification: $e');
    }
  }

  @override
  Future<void> resendOTP({required String email}) async {
    try {
      await _supabaseClient.auth.resend(type: OtpType.email, email: email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during OTP resend: $e');
    }
  }
}