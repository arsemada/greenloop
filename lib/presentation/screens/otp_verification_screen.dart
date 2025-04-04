import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/verify_otp_use_case.dart';
import '../../application/resend_otp_use_case.dart';
import '../../infrastructure/repositories/supabase_user_repository.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  late final VerifyOTPUseCase _verifyOTPUseCase;
  late final ResendOTPUseCase _resendOTPUseCase;

  @override
  void initState() {
    super.initState();
    final userRepository = SupabaseUserRepository(Supabase.instance.client);
    _verifyOTPUseCase = VerifyOTPUseCase(userRepository);
    _resendOTPUseCase = ResendOTPUseCase(userRepository);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.trim().isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _verifyOTPUseCase.execute(widget.email, _otpController.text.trim());
        // Navigate to a success screen or the main app
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text('Email Verified!')))), // Replace with your actual home screen
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to verify OTP: ${e.toString()}';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please enter the OTP.';
      });
    }
  }

  Future<void> _resendOTP() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _resendOTPUseCase.execute(widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New OTP sent to your email.')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to resend OTP: ${e.toString()}';
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please enter the 6-digit code sent to ${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: 'OTP Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyOTP,
              child: Text(_isLoading ? 'Verifying...' : 'Verify OTP'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _isLoading ? null : _resendOTP,
              child: const Text('Resend OTP'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}