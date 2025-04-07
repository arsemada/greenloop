import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  });
  Future<User?> getCurrentUser();
}