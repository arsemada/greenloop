import 'package:flutter/material.dart';
import './greenloop_theme.dart';

class WasteTrackingScreen extends StatelessWidget {
  final List<String> wasteTypes = ["Plastic", "Paper", "Metal", "Organic"];

  WasteTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Waste"),
        backgroundColor: GreenLoopTheme.primaryGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              items: wasteTypes.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              )).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: "Select Waste Type",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {}, // Future AI processing feature
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Capture Image (Mock)",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.secondaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Submit (Earn GreenTokens)",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}