import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/auth/sign_up_user.dart';
import '../../infrastructure/repositories/supabase_auth_repository.dart';
import '../../infrastructure/repositories/supabase_profile_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, String? verificationError});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  late final SignUpUser _signUpUser;

  @override
  void initState() {
    super.initState();
    final supabaseClient = Supabase.instance.client;
    final authRepository = SupabaseAuthRepository(supabaseClient);
    final profileRepository = SupabaseProfileRepository(supabaseClient);
    _signUpUser = SignUpUser(authRepository, profileRepository);
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _signUpUser.execute(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: '', // Optional for now
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful! Please check your email to confirm your account.'),
        ),
      );
      // Optionally navigate to a message screen or login screen
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign up failed: ${e.toString()}';
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
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
            TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
            TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: Text(_isLoading ? 'Sign Up' : 'Signing Up...'),
            ),
            if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}