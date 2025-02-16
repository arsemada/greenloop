import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import './onboarding_screen.dart';
import './greenloop_theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenLoopTheme.backgroundWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/earth.json', width: 200, height: 200),
          Text(
            "Welcome to GreenLoop",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: GreenLoopTheme.textDark,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Transforming waste into wealth. Join the movement for a cleaner, greener future!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: GreenLoopTheme.textDark,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: GreenLoopTheme.primaryGreen,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              "Get Started",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}