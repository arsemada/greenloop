import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class GetCurrentUser {
  final AuthRepository _authRepository;

  GetCurrentUser(this._authRepository);

  Future<User?> execute() async {
    return _authRepository.getCurrentUser();
  }
}