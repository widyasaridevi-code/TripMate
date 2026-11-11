
class WeatherModel {
  final double temperature;
  final double windSpeed;
  final int weatherCode;

  WeatherModel({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];

    if (current is! Map<String, dynamic>) {
      throw const FormatException('Data cuaca tidak valid');
    }

    final temperature = current['temperature_2m'];
    final windSpeed = current['wind_speed_10m'];
    final weatherCode = current['weather_code'];

    if (temperature is! num ||
        windSpeed is! num ||
        weatherCode is! num) {
      throw const FormatException('Format nilai cuaca tidak valid');
    }

    return WeatherModel(
      temperature: temperature.toDouble(),
      windSpeed: windSpeed.toDouble(),
      weatherCode: weatherCode.toInt(),
    );
  }

  String get description {
    if (weatherCode == 0) return 'Clear sky';
    if ([1, 2, 3].contains(weatherCode)) return 'Partly cloudy';
    if ([45, 48].contains(weatherCode)) return 'Fog';
    if ([51, 53, 55, 56, 57].contains(weatherCode)) {
      return 'Drizzle';
    }
    if ([61, 63, 65, 66, 67].contains(weatherCode)) {
      return 'Rain';
    }
    if ([71, 73, 75, 77].contains(weatherCode)) {
      return 'Snow';
    }
    if ([80, 81, 82].contains(weatherCode)) return 'Rain showers';
    if ([95, 96, 99].contains(weatherCode)) {
      return 'Thunderstorm';
    }

    return 'Unknown weather';
  }
}
