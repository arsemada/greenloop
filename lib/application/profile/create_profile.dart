import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile.dart';

class CreateProfile {
  final ProfileRepository _profileRepository;

  CreateProfile(this._profileRepository);

  Future<void> execute(Profile profile) async {
    await _profileRepository.saveProfile(profile);
  }
}