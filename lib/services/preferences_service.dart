
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _nameKey = 'user_name';
  static const String _emailKey = 'user_email';
  static const String _destinationKey = 'favorite_destination';
  static const String _travelStyleKey = 'travel_style';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _visibilityKey = 'profile_visibility';
  static const String _locationKey = 'location_sharing';

  static Future<void> saveProfile({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
  }

  static Future<Map<String, String>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'name': prefs.getString(_nameKey) ?? 'Komang Widyasari Devi',
      'email': prefs.getString(_emailKey) ?? '',
    };
  }

  static Future<void> saveTravelPreferences({
    required String destination,
    required String style,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_destinationKey, destination);
    await prefs.setString(_travelStyleKey, style);
  }

  static Future<Map<String, String>> getTravelPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'destination':
          prefs.getString(_destinationKey) ?? 'Not selected',
      'style': prefs.getString(_travelStyleKey) ?? 'Not selected',
    };
  }

  static Future<void> saveSettings({
    required bool notifications,
    required bool visibility,
    required bool location,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_notificationsKey, notifications);
    await prefs.setBool(_visibilityKey, visibility);
    await prefs.setBool(_locationKey, location);
  }

  static Future<Map<String, bool>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'notifications': prefs.getBool(_notificationsKey) ?? true,
      'visibility': prefs.getBool(_visibilityKey) ?? true,
      'location': prefs.getBool(_locationKey) ?? false,
    };
  }
}
