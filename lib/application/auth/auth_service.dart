import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //sigining in with email and password
  Future<AuthResponse> siginInWithEmailAndPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //signing up with email and password
 Future<AuthResponse> sigUpInWithEmailAndPassword(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }
  //signing out
Future<void> signOut() async {
   await _supabase.auth.signOut();
  }
  //Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
}
}