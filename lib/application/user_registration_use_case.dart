import '../domain/repositories/user_repository.dart';

class UserRegistrationUseCase {
  final UserRepository _userRepository;

  UserRegistrationUseCase(this._userRepository);

  Future<String> execute({
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    required String password,
  }) async {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw InvalidEmailException('Please enter a valid email address.');
    }
    return _userRepository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );
  }
}

class VerifyOTPUseCase {
  final UserRepository _userRepository;

  VerifyOTPUseCase(this._userRepository);

  Future<void> execute(String email, String otp) async {
    await _userRepository.verifyOTP(email: email, otp: otp);
  }
}

class ResendOTPUseCase {
  final UserRepository _userRepository;

  ResendOTPUseCase(this._userRepository);

  Future<void> execute(String email) async {
    await _userRepository.resendOTP(email: email);
  }
}

class InvalidEmailException implements Exception {
  final String message;
  InvalidEmailException(this.message);
  @override
  String toString() => 'InvalidEmailException: $message';
}