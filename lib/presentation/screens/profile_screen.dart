import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/profile/get_profile.dart';
import '../../application/auth/get_current_user.dart';
import '../../infrastructure/repositories/supabase_auth_repository.dart';
import '../../infrastructure/repositories/supabase_profile_repository.dart';
import '../../domain/entities/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? _profileData;
  bool _isLoading = true;

  late final GetProfile _getProfile;
  late final GetCurrentUser _getCurrentUser;

  @override
  void initState() {
    super.initState();
    final supabaseClient = Supabase.instance.client;
    final profileRepository = SupabaseProfileRepository(supabaseClient);
    final authRepository = SupabaseAuthRepository(supabaseClient);
    _getProfile = GetProfile(profileRepository);
    _getCurrentUser = GetCurrentUser(authRepository);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _profileData = null;
    });
    final user = await _getCurrentUser.execute();
    if (user != null && user.isEmailConfirmed) {
      final profile = await _getProfile.execute(user.id);
      setState(() {
        _profileData = profile;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      if (user != null && !user.isEmailConfirmed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please confirm your email first.')),
        );
      }
      // Optionally navigate back to the sign-up or a waiting screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _profileData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome, ${_profileData!.firstName} ${_profileData!.lastName}!'),
                      Text('Email: ${_profileData!.email}'),
                      if (_profileData!.phoneNumber != null) Text('Phone: ${_profileData!.phoneNumber!}'),
                    ],
                  )
                : const Text('Could not load profile information or email not confirmed.'),
      ),
    );
  }
}