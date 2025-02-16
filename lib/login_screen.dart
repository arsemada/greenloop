import 'package:flutter/material.dart';
import './dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen())),
              child: Text("Login with Google (Mock)"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen())),
              child: Text("Login with Email (Mock)"),
            ),
          ],
        ),
      ),
    );
  }
}
