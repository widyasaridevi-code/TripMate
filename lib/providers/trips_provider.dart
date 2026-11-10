
import 'package:flutter/foundation.dart';
import '../repositories/saved_trips_repository.dart';

class TripsProvider extends ChangeNotifier {
  final SavedTripsRepository _repository;

  TripsProvider(this._repository);

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  String? errorMessage;

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

  // Menyesuaikan data Supabase dengan format yang dipakai UI
  Map<String, dynamic> _formatTrip(Map<String, dynamic> trip) {
    return {
      ...trip,
      'date': trip['travel_date'] ?? trip['date'] ?? '',
      'image': trip['image'] ?? '',
    };
  }

  // READ
  Future<void> loadTrips() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.getTrips();

      _trips
        ..clear()
        ..addAll(result.map(_formatTrip));
    } catch (e) {
      errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // CREATE
  Future<void> addTrip({
    required String destination,
    required String location,
    required String date,
  }) async {
    try {
      final result = await _repository.addTrip({
        'destination': destination,
        'location': location,
        'travel_date': date,
        'status': 'Upcoming',
      });

      _trips.insert(0, _formatTrip(result));

      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // UPDATE
  Future<void> updateTrip(
    int id,
    Map<String, dynamic> updatedTrip,
  ) async {
    try {
      final result = await _repository.updateTrip(
        id,
        updatedTrip,
      );

      final index = _trips.indexWhere(
        (trip) => trip['id'] == id,
      );

      if (index != -1) {
        _trips[index] = _formatTrip(result);
      }

      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // DELETE
  Future<void> deleteTrip(int id) async {
    try {
      await _repository.deleteTrip(id);

      _trips.removeWhere(
        (trip) => trip['id'] == id,
      );

      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
