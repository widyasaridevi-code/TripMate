
import '../services/saved_trips_service.dart';

class SavedTripsRepository {
  final SavedTripsService _service;

  SavedTripsRepository(this._service);

  // READ
  Future<List<Map<String, dynamic>>> getTrips() {
    return _service.getTrips();
  }

  // CREATE
  Future<Map<String, dynamic>> addTrip(
    Map<String, dynamic> trip,
  ) {
    return _service.addTrip(trip);
  }

  // UPDATE
  Future<Map<String, dynamic>> updateTrip(
    int id,
    Map<String, dynamic> trip,
  ) {
    return _service.updateTrip(id, trip);
  }

  // DELETE
  Future<void> deleteTrip(int id) {
    return _service.deleteTrip(id);
  }
}
