
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,wind_speed_10m,weather_code',
      },
    );

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception('Format data cuaca tidak valid');
      }

      return WeatherModel.fromJson(data);
    } else {
      throw Exception(
        'Gagal mengambil data cuaca: ${response.statusCode}',
      );
    }
  }
}
