import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile.dart';

class GetProfile {
  final ProfileRepository _profileRepository;

  GetProfile(this._profileRepository);

  Future<Profile?> execute(String id) async {
    return _profileRepository.getProfile(id);
  }
}