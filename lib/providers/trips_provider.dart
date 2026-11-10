
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripsProvider extends ChangeNotifier {
  static const String _tripsKey = 'saved_trips';

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  final List<Map<String, dynamic>> _trips = [];

  List<Map<String, dynamic>> get trips =>
      List.unmodifiable(_trips);

  List<Map<String, dynamic>> get upcomingTrips =>
      _trips
          .where((trip) => trip['status'] == 'Upcoming')
          .toList();

  List<Map<String, dynamic>> get completedTrips =>
      _trips
          .where((trip) => trip['status'] == 'Completed')
          .toList();

  final List<Map<String, dynamic>> _defaultTrips = [
    {
      'destination': 'Bali',
      'location': 'Indonesia',
      'date': '15 - 18 December 2026',
      'status': 'Upcoming',
      'image':
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    },
    {
      'destination': 'Raja Ampat',
      'location': 'West Papua, Indonesia',
      'date': '10 - 14 August 2026',
      'status': 'Completed',
      'image':
          'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=800',
    },
  ];

  Future<void> loadTrips() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTrips = prefs.getString(_tripsKey);

      if (savedTrips != null) {
        final List<dynamic> decodedTrips =
            jsonDecode(savedTrips);

        _trips
          ..clear()
          ..addAll(
            decodedTrips.map(
              (trip) => Map<String, dynamic>.from(trip),
            ),
          );
      } else {
        _trips
          ..clear()
          ..addAll(
            _defaultTrips.map(
              (trip) => Map<String, dynamic>.from(trip),
            ),
          );

        await _saveTrips();
      }
    } catch (e) {
      _trips
        ..clear()
        ..addAll(
          _defaultTrips.map(
            (trip) => Map<String, dynamic>.from(trip),
          ),
        );

      await _saveTrips();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTrip({
    required String destination,
    required String location,
    required String date,
  }) async {
    _trips.insert(0, {
      'destination': destination,
      'location': location,
      'date': date,
      'status': 'Upcoming',
      'image': '',
    });

    await _saveTrips();
    notifyListeners();
  }

  Future<void> _saveTrips() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _tripsKey,
      jsonEncode(_trips),
    );
  }
}
