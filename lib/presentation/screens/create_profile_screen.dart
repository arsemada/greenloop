import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateProfileScreen extends StatefulWidget {
  final String userId;

  const CreateProfileScreen({super.key, required this.userId});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _createProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await Supabase.instance.client.from('profiles').insert({
        'id': widget.userId,
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone_number': _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      });
      // Navigate to your main app screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text('Profile Created!')))), // Replace with your main screen
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to create profile: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
            TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone Number (Optional)')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _isLoading ? null : _createProfile, child: Text(_isLoading ? 'Creating...' : 'Create Profile')),
            if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}