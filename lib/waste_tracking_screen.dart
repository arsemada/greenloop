import 'package:flutter/material.dart';

class WasteTrackingScreen extends StatelessWidget {
  final List<String> wasteTypes = ["Plastic", "Paper", "Metal", "Organic"];

  WasteTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log Waste")),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            items: wasteTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            onChanged: (value) {},
            hint: Text("Select Waste Type"),
          ),
          ElevatedButton(
            onPressed: () {}, // Future AI processing feature
            child: Text("Capture Image (Mock)"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Submit (Earn GreenTokens)"),
          ),
        ],
      ),
    );
  }
}
