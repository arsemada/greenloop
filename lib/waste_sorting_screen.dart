import 'package:flutter/material.dart';
import './greenloop_theme.dart';

class WasteSortingScreen extends StatelessWidget {
  const WasteSortingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Sort Waste"),
        backgroundColor: GreenLoopTheme.primaryGreen,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildInstruction("Plastic", "Clean and dry plastic bottles, containers, and bags."),
          _buildInstruction("Paper", "Flatten cardboard and remove any non-paper materials."),
          _buildInstruction("Metal", "Rinse cans and separate aluminum from steel."),
          _buildInstruction("Organic", "Compost food scraps and yard waste."),
        ],
      ),
    );
  }

  Widget _buildInstruction(String title, String description) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: GreenLoopTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: GreenLoopTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}