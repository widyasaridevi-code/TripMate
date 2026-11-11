
import 'package:flutter/foundation.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  final Map<String, WeatherModel> _weatherData = {};

  bool _isLoading = false;
  String? _errorMessage;
  bool _hasLoaded = false;
  bool _isDisposed = false;

  Map<String, WeatherModel> get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadWeather() async {
    if (_hasLoaded || _isLoading || _isDisposed) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final destinations = {
      'Ubud': [-8.5069, 115.2625],
      'Raja Ampat': [-0.4333, 130.8167],
      'Mount Bromo': [-7.9425, 112.9530],
      'Jakarta': [-6.2088, 106.8456],
    };

    bool hasError = false;

    try {
      for (final destination in destinations.entries) {
        if (_isDisposed) return;

        // Lewati destinasi yang datanya sudah berhasil dimuat.
        if (_weatherData.containsKey(destination.key)) continue;

        try {
          final weather = await _weatherService.getWeather(
            latitude: destination.value[0],
            longitude: destination.value[1],
          );

          if (_isDisposed) return;

          _weatherData[destination.key] = weather;
        } catch (e) {
          hasError = true;
        }
      }

      _hasLoaded = _weatherData.length == destinations.length;

      if (hasError) {
        _errorMessage = 'Gagal mengambil sebagian data cuaca';
      }
    } finally {
      _isLoading = false;

      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
