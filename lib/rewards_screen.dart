import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Rewards")),
      body: Center(child: Text("GreenTokens = Discounts & Badges! (Mock UI)")),
    );
  }
}
