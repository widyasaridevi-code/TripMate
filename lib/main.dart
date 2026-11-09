
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TripMateApp());
}

class TripMateApp extends StatelessWidget {
  const TripMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripMate',
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'TripMate\nYour journey, beautifully planned.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
