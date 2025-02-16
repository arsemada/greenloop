import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import './login_screen.dart';
import './greenloop_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenLoopTheme.backgroundWhite,
      body: PageView(
        children: [
          buildPage(
            context,
            "Track & Earn Rewards",
            "Recycle waste and earn GreenTokens for discounts and badges!",
            "assets/animations/recycle1.json",
          ),
          buildPage(
            context,
            "Find Collection Points",
            "Locate nearby recycling stations with ease.",
            "assets/animations/map.json",
          ),
          buildPage(
            context,
            "Learn to Sort Waste",
            "Follow simple instructions to sort waste correctly.",
            "assets/animations/sorting.json",
            showButton: true,
          ),
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, String title, String subtitle, String animation,
      {bool showButton = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, width: 300, height: 300),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: GreenLoopTheme.textDark,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: GreenLoopTheme.textDark,
            ),
          ),
        ),
        if (showButton)
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
    );
  }
}