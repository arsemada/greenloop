import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/user.dart';

class SignUpUser {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  SignUpUser(this._authRepository, this._profileRepository);

  Future<User> execute({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    final user = await _authRepository.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    final profile = Profile(
      id: user.id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );
    await _profileRepository.saveProfile(profile);
    return user;
  }
}