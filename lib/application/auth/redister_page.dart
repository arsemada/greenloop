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

  void signUp()async{
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPassword.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    try {
      await authService.sigUpInWithEmailAndPassword(email, password);
      // Navigate to the next page after successful login
      Navigator.pop(context); // Go back to the previous page
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    } finally {
      _emailController.clear();
      _passwordController.clear();
      _confirmPassword.clear();
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