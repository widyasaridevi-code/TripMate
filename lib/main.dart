import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/trips_provider.dart';
import 'providers/weather_provider.dart';
import 'screens/main_navigation_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TripsProvider()..loadTrips(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: const TripMateApp(),
    ),
  );
}

class TripMateApp extends StatelessWidget {
  const TripMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripMate',
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}