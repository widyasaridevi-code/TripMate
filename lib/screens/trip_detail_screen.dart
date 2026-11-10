
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TripDetailScreen extends StatelessWidget {
  final Map<String, dynamic> trip;

  const TripDetailScreen({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = trip['status'] == 'Upcoming';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Trip Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
          ),
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.charcoal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: trip['image'].toString().isNotEmpty
                  ? Image.network(
                      trip['image'],
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imagePlaceholder();
                      },
                    )
                  : _imagePlaceholder(),
            ),
            const SizedBox(height: 22),
            Text(
              trip['destination'] ?? 'Unknown Destination',
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    trip['location'] ?? '-',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Trip Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.calendar_month_outlined,
              title: 'Travel Date',
              value: trip['date'] ?? '-',
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.flag_outlined,
              title: 'Trip Status',
              value: trip['status'] ?? '-',
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.place_outlined,
              title: 'Destination',
              value: trip['destination'] ?? '-',
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isUpcoming
                    ? AppColors.softSage
                    : AppColors.sand,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    isUpcoming
                        ? Icons.luggage_outlined
                        : Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 25,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isUpcoming
                          ? 'Get ready for your next adventure!'
                          : 'You have completed this adventure. Keep the memories!',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.softSage,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 220,
      width: double.infinity,
      color: AppColors.softSage,
      child: const Icon(
        Icons.landscape_outlined,
        size: 55,
        color: AppColors.primary,
      ),
    );
  }
}
