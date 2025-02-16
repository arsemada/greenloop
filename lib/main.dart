import 'package:flutter/material.dart';
import './onboarding_screen.dart';

void main() {
  runApp(GreenLoopApp());
}

class GreenLoopApp extends StatelessWidget {
  const GreenLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenLoop',
      theme: ThemeData(primarySwatch: Colors.green),
      home: OnboardingScreen(),
    );
  }
}
