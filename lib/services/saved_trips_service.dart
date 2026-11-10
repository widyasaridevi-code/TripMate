
import 'package:supabase_flutter/supabase_flutter.dart';

class SavedTripsService {
  final SupabaseClient _client = Supabase.instance.client;

  // READ: Mengambil semua data perjalanan
  Future<List<Map<String, dynamic>>> getTrips() async {
    final response = await _client
        .from('saved_trips')
        .select()
        .order('id', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  // CREATE: Menambahkan perjalanan
  Future<Map<String, dynamic>> addTrip(
    Map<String, dynamic> trip,
  ) async {
    final response = await _client
        .from('saved_trips')
        .insert(trip)
        .select()
        .single();

    return response;
  }

  // UPDATE: Mengubah data perjalanan
  Future<Map<String, dynamic>> updateTrip(
    int id,
    Map<String, dynamic> trip,
  ) async {
    final response = await _client
        .from('saved_trips')
        .update(trip)
        .eq('id', id)
        .select()
        .single();

    return response;
  }

  // DELETE: Menghapus perjalanan
  Future<void> deleteTrip(int id) async {
    await _client
        .from('saved_trips')
        .delete()
        .eq('id', id);
  }
}
