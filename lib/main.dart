import 'package:flutter/material.dart';
import './landing_page.dart';
import './greenloop_theme.dart';

void main() {
  runApp(GreenLoopApp());
}

class GreenLoopApp extends StatelessWidget {
  const GreenLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenLoop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: GreenLoopTheme.backgroundWhite,
      ),
      home: LandingPage(),
    );
  }
}