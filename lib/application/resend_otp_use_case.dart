import '../domain/repositories/user_repository.dart';

class ResendOTPUseCase {
  final UserRepository _userRepository;

  ResendOTPUseCase(this._userRepository);

  Future<void> execute(String email) async {
    await _userRepository.resendOTP(email: email);
  }
}