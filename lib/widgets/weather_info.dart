
import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_colors.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel? weather;
  final bool isLoading;
  final String? errorMessage;

  const WeatherInfo({
    super.key,
    this.weather,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Weather berhasil dimuat
    if (weather != null) {
      return Row(
        children: [
          const Icon(
            Icons.wb_cloudy_outlined,
            size: 15,
            color: AppColors.primary,
          ),
          const SizedBox(width: 5),
          Text(
            '${weather!.temperature.toStringAsFixed(1)}°C · ${weather!.description}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    // Sedang mengambil data weather
    if (isLoading) {
      return const Row(
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 6),
          Text(
            'Loading weather...',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }

    // API gagal atau data tidak tersedia
    return Tooltip(
      message: errorMessage ?? 'Weather data is unavailable',
      child: const Row(
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 14,
            color: Colors.grey,
          ),
          SizedBox(width: 5),
          Text(
            'Weather unavailable',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
