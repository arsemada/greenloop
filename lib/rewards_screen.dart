import 'package:flutter/material.dart';
import './greenloop_theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Rewards"),
        backgroundColor: GreenLoopTheme.primaryGreen,
      ),
      body: Center(
        child: Text(
          "GreenTokens = Discounts & Badges! (Mock UI)",
          style: TextStyle(fontSize: 18, color: GreenLoopTheme.textDark),
        ),
      ),
    );
  }
}