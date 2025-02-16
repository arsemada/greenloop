import 'package:flutter/material.dart';
import './waste_tracking_screen.dart';
import './collection_points_screen.dart';
import './rewards_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GreenLoop Dashboard")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your Impact: ♻️ 10kg Waste Recycled", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("GreenTokens: 💰 50", style: TextStyle(fontSize: 18, color: Colors.green)),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WasteTrackingScreen())),
            child: Text("Log Your Waste"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CollectionPointsScreen())),
            child: Text("Find Recycling Stations"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RewardsScreen())),
            child: Text("View Rewards"),
          ),
        ],
      ),
    );
  }
}
