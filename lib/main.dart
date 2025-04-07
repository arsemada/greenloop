import 'package:flutter/material.dart';
import 'package:greenloop/application/auth/redister_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/screens/sign_up_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/auth_callback_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:greenloop/application/auth/auth_get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // Use clean URL paths

  await Supabase.initialize(
    url: 'https://jlvnjdxznihneinchcuw.supabase.co', // Replace with your Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impsdm5qZHh6bmlobmVpbmNoY3V3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMTE3NDAsImV4cCI6MjA1OTU4Nzc0MH0.1fDVwFDJGLqHxXDwvtcJYodOmkGMsEATEaTU3d3Gttw', // Replace with your Supabase anon key
  );

  runApp(const MyApp());
}

// void main() async{
//   //Supabase setup
// await Supabase.initialize(
//   anonKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2cXN6cXFya25sa3ViamlscHNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMTEzMjAsImV4cCI6MjA1OTU4NzMyMH0.QPKtvmju4W_XGCvCIxePrCNU5dMJri6NJWzyiSLTz78" ,
//   url:"https://dvqszqqrknlkubjilpsj.supabase.co" ,
// );

//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenloop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/', // Set the initial route to the SignUpScreen
      routes: {
        '/': (context) => const AuthGet(),
        // '/auth/callback': (context) => const AuthCallbackScreen(),
        // '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
