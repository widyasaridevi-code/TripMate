
import '../models/trip_model.dart';
import '../services/saved_trips_service.dart';

class SavedTripsRepository {
  final SavedTripsService _service;

  SavedTripsRepository(this._service);

  // READ
  Future<List<TripModel>> getTrips() async {
    final result = await _service.getTrips();

    return result
        .map((trip) => TripModel.fromJson(trip))
        .toList();
  }

  // CREATE
  Future<TripModel> addTrip(
    Map<String, dynamic> trip,
  ) async {
    final result = await _service.addTrip(trip);

    return TripModel.fromJson(result);
  }

  // UPDATE
  Future<TripModel> updateTrip(
    int id,
    Map<String, dynamic> trip,
  ) async {
    final result = await _service.updateTrip(id, trip);

    return TripModel.fromJson(result);
  }

  // DELETE
  Future<void> deleteTrip(int id) {
    return _service.deleteTrip(id);
  }
}
