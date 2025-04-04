import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/screens/sign_up_screen.dart'; // Import the SignUpScreen
import 'infrastructure/repositories/supabase_user_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'application/user_registration_use_case.dart';
import 'application/verify_otp_use_case.dart' as verify;
import 'application/resend_otp_use_case.dart' as resend;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dgsomrltofkpbnqkpfmw.supabase.co', // Replace with your Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRnc29tcmx0b2ZrcGJucWtwZm13Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2NjcxOTgsImV4cCI6MjA1OTI0MzE5OH0.sQsthL5_8dnHChUWfV8g4d4Jh58epLWmFiVfGOZlX64', // Replace with your Supabase anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Management App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // You can customize your theme
      ),
      home: const SignUpScreen(), // Set SignUpScreen as the initial screen
    );
  }
}

final supabase = Supabase.instance.client;

// You can also provide instances of your repositories and use cases here
// if you want to access them globally (though dependency injection is generally preferred
// for larger applications).
final UserRepository userRepository = SupabaseUserRepository(supabase);
final UserRegistrationUseCase registrationUseCase = UserRegistrationUseCase(userRepository);
final verify.VerifyOTPUseCase verifyOTPUseCase = verify.VerifyOTPUseCase(userRepository);
final resend.ResendOTPUseCase resendOTPUseCase = resend.ResendOTPUseCase(userRepository);