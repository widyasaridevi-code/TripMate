
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DestinationCard extends StatelessWidget {
  final String name;
  final String country;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.name,
    required this.country,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 115,
              width: 155,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 115,
                  width: 155,
                  color: AppColors.softSage,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.charcoal,
            ),
          ),
          Text(
            country,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
