import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/user_registration_use_case.dart';
import '../../infrastructure/repositories/supabase_user_repository.dart';
import 'otp_verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  late final UserRegistrationUseCase _registrationUseCase;

  @override
  void initState() {
    super.initState();
    final userRepository = SupabaseUserRepository(Supabase.instance.client);
    _registrationUseCase = UserRegistrationUseCase(userRepository);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _registrationUseCase.execute(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phoneNumber: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(email: _emailController.text.trim()),
          ),
        );
      } on InvalidEmailException catch (e) {
        setState(() {
          _errorMessage = e.message;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An unexpected error occurred: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value?.isEmpty == true ? 'Please enter your first name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value?.isEmpty == true ? 'Please enter your last name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value?.isEmpty == true || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!) ? 'Please enter a valid email' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number (Optional)'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => value?.isEmpty == true || value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                child: Text(_isLoading ? 'Signing Up...' : 'Sign Up'),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}