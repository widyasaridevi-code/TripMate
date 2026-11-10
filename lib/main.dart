
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_navigation_screen.dart';
import 'theme/app_theme.dart';

import 'providers/trips_provider.dart';
import 'providers/weather_provider.dart';

import 'services/saved_trips_service.dart';
import 'repositories/saved_trips_repository.dart';
import 'config/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseConfig.initialize();

  runApp(const TripMateApp());
}

class TripMateApp extends StatelessWidget {
  const TripMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TripsProvider(
            SavedTripsRepository(
              SavedTripsService(),
            ),
          )..loadTrips(),
        ),

        ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'TripMate',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
