import '../domain/repositories/user_repository.dart';

class VerifyOTPUseCase {
  final UserRepository _userRepository;

  VerifyOTPUseCase(this._userRepository);

  Future<void> execute(String email, String otp) async {
    await _userRepository.verifyOTP(email: email, otp: otp);
  }
}