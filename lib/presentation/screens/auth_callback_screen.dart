import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_screen.dart'; // Import your ProfileScreen
import 'sign_up_screen.dart'; // For potential error navigation

class AuthCallbackScreen extends StatefulWidget {
  const AuthCallbackScreen({super.key});

  @override
  State<AuthCallbackScreen> createState() => _AuthCallbackScreenState();
}

class _AuthCallbackScreenState extends State<AuthCallbackScreen> {
  bool _isConfirming = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _handleAuthCallback();
  }

  Future<void> _handleAuthCallback() async {
    final uri = Uri.base;
    final token = uri.queryParameters['token'];
    final type = uri.queryParameters['type'];

    if (type == 'signup' && token != null && token.isNotEmpty) {
      try {
        final response = await Supabase.instance.client.auth.verifyOTP(
          token: token,
          type: OtpType.email,
        );
        if (response.error == null) {
          setState(() {
            _isConfirming = false;
          });
          // Navigate to the ProfileScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else {
          setState(() {
            _isConfirming = false;
            _errorMessage = 'Email verification failed: ${response.error!.message}';
          });
          // Optionally navigate back to the sign-up screen with an error
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen(verificationError: _errorMessage)),
          );
        }
      } catch (e) {
        setState(() {
          _isConfirming = false;
          _errorMessage = 'Unexpected error during verification: $e';
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen(verificationError: _errorMessage)),
        );
      }
    } else {
      setState(() {
        _isConfirming = false;
        _errorMessage = 'Invalid verification link.';
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen(verificationError: _errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifying Email')),
      body: Center(
        child: _isConfirming
            ? const CircularProgressIndicator()
            : Text(
                _errorMessage ?? 'Verifying...',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}