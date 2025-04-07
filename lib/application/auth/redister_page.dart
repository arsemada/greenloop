import 'package:flutter/material.dart';
import 'package:greenloop/application/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authService = AuthService();
  final  _emailController = TextEditingController();
  final  _passwordController = TextEditingController();
  final  _confirmPassword = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();


  void signUp()async{
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPassword.text;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
try {
  final response = await authService.sigUpInWithEmailAndPassword(
  email,
  password,
  firstName,
  lastName,
);

// ✅ Make sure response.user is valid
if (response.user != null) {
  await authService.insertUserProfile(
    id: response.user!.id, // ✅ Pass the user ID
    firstName: firstName,
    lastName: lastName,
    email: email,
  );
}

  
  // Navigate to the next page after successful login
  Navigator.pop(context); // Go back to the previous page
} catch (e) {
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
} finally {
  _emailController.clear();
  _passwordController.clear();
  _confirmPassword.clear();
  _firstNameController.clear();
  _lastNameController.clear();
}

  }

  @override  
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            TextField(
              controller: _confirmPassword,
              decoration: const InputDecoration(labelText: 'Conferm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    ); 
  }
  }