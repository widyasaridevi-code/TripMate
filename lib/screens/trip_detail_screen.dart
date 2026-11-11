
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip_model.dart';
import '../providers/trips_provider.dart';
import '../theme/app_colors.dart';

class TripDetailScreen extends StatelessWidget {
  final TripModel trip;

  const TripDetailScreen({
    super.key,
    required this.trip,
  });

  Future<void> editTrip(BuildContext context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => _EditTripDialog(trip: trip),
    );

    if (result == null || !context.mounted) return;

    if (trip.id == null) return;

    try {
      await context.read<TripsProvider>().updateTrip(
        trip.id!,
        {
          'destination': result['destination']!,
          'location': result['location']!,
          'travel_date': result['date']!,
        },
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip updated successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update trip: $e')),
      );
    }
  }

  Future<void> deleteTrip(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Trip?'),
        content: const Text(
          'Are you sure you want to delete this trip?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true || !context.mounted) return;

    if (trip.id == null) return;

    try {
      await context.read<TripsProvider>().deleteTrip(trip.id!);

      if (!context.mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip deleted successfully!'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete trip: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpcoming = trip.status == 'Upcoming';

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
        actions: [
          IconButton(
            onPressed: () => editTrip(context),
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Trip',
          ),
          IconButton(
            onPressed: () => deleteTrip(context),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            tooltip: 'Delete Trip',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: trip.image.isNotEmpty
                  ? Image.network(
                      trip.image,
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
              trip.destination.isNotEmpty
                  ? trip.destination
                  : 'Unknown Destination',
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
                    trip.location.isNotEmpty ? trip.location : '-',
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
              value: trip.date.isNotEmpty ? trip.date : '-',
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.flag_outlined,
              title: 'Trip Status',
              value: trip.status,
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.place_outlined,
              title: 'Destination',
              value: trip.destination.isNotEmpty
                  ? trip.destination
                  : '-',
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

class _EditTripDialog extends StatefulWidget {
  final TripModel trip;

  const _EditTripDialog({required this.trip});

  @override
  State<_EditTripDialog> createState() => _EditTripDialogState();
}

class _EditTripDialogState extends State<_EditTripDialog> {
  late final TextEditingController destinationController;
  late final TextEditingController locationController;
  late final TextEditingController dateController;

  @override
  void initState() {
    super.initState();

    destinationController = TextEditingController(
      text: widget.trip.destination,
    );

    locationController = TextEditingController(
      text: widget.trip.location,
    );

    dateController = TextEditingController(
      text: widget.trip.date,
    );
  }

  @override
  void dispose() {
    destinationController.dispose();
    locationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void submit() {
    final destination = destinationController.text.trim();
    final location = locationController.text.trim();
    final date = dateController.text.trim();

    if (destination.isEmpty || location.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields.'),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'destination': destination,
      'location': location,
      'date': date,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Trip'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Travel Date',
                hintText: 'e.g. 20/12/2026',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: submit,
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}
