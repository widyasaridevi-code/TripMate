import 'package:flutter/foundation.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  final Map<String, WeatherModel> _weatherData = {};

  bool _isLoading = false;
  String? _errorMessage;
  bool _hasLoaded = false;

  Map<String, WeatherModel> get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadWeather() async {
    if (_hasLoaded || _isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final destinations = {
      'Ubud': [-8.5069, 115.2625],
      'Raja Ampat': [-0.4333, 130.8167],
      'Mount Bromo': [-7.9425, 112.9530],
      'Jakarta': [-6.2088, 106.8456],
    };

    try {
      for (final destination in destinations.entries) {
        final weather = await _weatherService.getWeather(
          latitude: destination.value[0],
          longitude: destination.value[1],
        );

        _weatherData[destination.key] = weather;
      }

      _hasLoaded = true;
    } catch (e) {
      _errorMessage = 'Gagal mengambil data cuaca';
    }

    _isLoading = false;
    notifyListeners();
  }
}