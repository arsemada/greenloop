import 'package:flutter/material.dart';
import './login_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          buildPage(context, "Welcome to GreenLoop!",
              "Track & earn rewards for recycling", "../assets/recycle1.jpeg"),
          buildPage(
              context,
              "Find Collection Points",
              "Easily locate nearby recycling stations",
              "../assets/recycle2.jpeg"),
          buildPage(context, "Start Recycling!",
              "Join the Green Movement today!", "../assets/recycle3.jpeg",
              showButton: true),
        ],
      ),
    );
  }

  Widget buildPage(
      BuildContext context, String title, String subtitle, String animation,
      {bool showButton = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, width: 300, height: 300),
        Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(subtitle, textAlign: TextAlign.center),
        ),
        if (showButton)
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen())),
            child: Text("Get Started"),
          ),
      ],
    );
  }
}
