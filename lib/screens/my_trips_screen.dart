
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trips_provider.dart';
import '../theme/app_colors.dart';
import 'trip_detail_screen.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  Future<void> addTrip(BuildContext context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) {
        return const _AddTripDialog();
      },
    );

    if (result != null && context.mounted) {
      await context.read<TripsProvider>().addTrip(
            destination: result['destination']!,
            location: result['location']!,
            date: result['date']!,
          );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trip saved successfully!'),
          ),
        );
      }
    }
  }

  void openTripDetail(
    BuildContext context,
    Map<String, dynamic> trip,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailScreen(
          trip: trip,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripsProvider = context.watch<TripsProvider>();

    final upcomingTrips = tripsProvider.upcomingTrips;
    final completedTrips = tripsProvider.completedTrips;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: tripsProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Adventures',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'My Trips',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          backgroundColor: AppColors.softSage,
                          child: Icon(
                            Icons.luggage,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => addTrip(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Plan a New Trip'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildSectionTitle(
                      'Upcoming Trips',
                      upcomingTrips.length,
                    ),
                    const SizedBox(height: 15),
                    if (upcomingTrips.isEmpty)
                      _buildEmptyState('No upcoming trips yet.')
                    else
                      ...upcomingTrips.map(
                        (trip) => _buildTripCard(context, trip),
                      ),
                    const SizedBox(height: 20),
                    _buildSectionTitle(
                      'Completed Trips',
                      completedTrips.length,
                    ),
                    const SizedBox(height: 15),
                    if (completedTrips.isEmpty)
                      _buildEmptyState('No completed trips yet.')
                    else
                      ...completedTrips.map(
                        (trip) => _buildTripCard(context, trip),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
          ),
        ),
        Text(
          '$count trips',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildTripCard(
    BuildContext context,
    Map<String, dynamic> trip,
  ) {
    final isUpcoming = trip['status'] == 'Upcoming';

    return GestureDetector(
      onTap: () => openTripDetail(context, trip),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: trip['image'].toString().isNotEmpty
                  ? Image.network(
                      trip['image'],
                      height: 155,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imagePlaceholder();
                      },
                    )
                  : _imagePlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          trip['destination'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isUpcoming
                              ? AppColors.softSage
                              : AppColors.sand,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          trip['status'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trip['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trip['date'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 155,
      width: double.infinity,
      color: AppColors.softSage,
      child: const Icon(
        Icons.landscape_outlined,
        size: 45,
        color: AppColors.primary,
      ),
    );
  }
}

class _AddTripDialog extends StatefulWidget {
  const _AddTripDialog();

  @override
  State<_AddTripDialog> createState() => _AddTripDialogState();
}

class _AddTripDialogState extends State<_AddTripDialog> {
  final destinationController = TextEditingController();
  final locationController = TextEditingController();

  DateTime? selectedDate;

  @override
  void dispose() {
    destinationController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> selectTripDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateUtils.dateOnly(DateTime.now()),
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime(2035),
    );

    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void submitTrip() {
    final destination = destinationController.text.trim();
    final location = locationController.text.trim();

    if (destination.isEmpty ||
        location.isEmpty ||
        selectedDate == null) {
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
      'date':
          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Trip'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'e.g. Yogyakarta',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'e.g. Indonesia',
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: selectTripDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                selectedDate == null
                    ? 'Select Date'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: submitTrip,
          child: const Text('Add Trip'),
        ),
      ],
    );
  }
}
