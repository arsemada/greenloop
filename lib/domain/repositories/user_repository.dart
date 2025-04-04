import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<User?> getUserProfile(String id);
  Future<String> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  });
  Future<void> verifyOTP({required String email, required String otp});
  Future<void> resendOTP({required String email});
}