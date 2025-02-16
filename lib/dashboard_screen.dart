import 'package:flutter/material.dart';
import './waste_tracking_screen.dart';
import './collection_points_screen.dart';
import './rewards_screen.dart';
import './waste_sorting_screen.dart';
import './greenloop_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GreenLoop Dashboard"),
        backgroundColor: GreenLoopTheme.primaryGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Impact: ♻️ 10kg Waste Recycled",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "GreenTokens: 💰 50",
              style: TextStyle(fontSize: 18, color: GreenLoopTheme.accentYellow),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WasteTrackingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Log Your Waste",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollectionPointsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Find Recycling Stations",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RewardsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "View Rewards",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WasteSortingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GreenLoopTheme.secondaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Learn to Sort Waste",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}