
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Account',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),

              const SizedBox(height: 25),

              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: AppColors.softSage,
                      child: const Text(
                        'K',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Komang Widyasari Devi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Travel Enthusiast',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softSage,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'TripMate Member',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Personal Information
              _buildSectionTitle('Personal Information'),
              const SizedBox(height: 12),

              _buildInfoCard([
                _buildMenuItem(
                  Icons.person_outline,
                  'Full Name',
                  'Komang Widyasari Devi',
                ),
                _buildMenuItem(
                  Icons.email_outlined,
                  'Email Address',
                  'Not added yet',
                ),
                _buildMenuItem(
                  Icons.location_on_outlined,
                  'Country',
                  'Indonesia',
                ),
              ]),

              const SizedBox(height: 25),

              // Travel Preferences
              _buildSectionTitle('Travel Preferences'),
              const SizedBox(height: 12),

              _buildInfoCard([
                _buildMenuItem(
                  Icons.beach_access_outlined,
                  'Favorite Destination',
                  'Explore your favorite places',
                ),
                _buildMenuItem(
                  Icons.luggage_outlined,
                  'Travel Style',
                  'Discover your travel style',
                ),
              ]),

              const SizedBox(height: 25),

              // Settings
              _buildSectionTitle('Settings'),
              const SizedBox(height: 12),

              _buildInfoCard([
                _buildMenuItem(
                  Icons.notifications_none,
                  'Notifications',
                  'Manage your notifications',
                ),
                _buildMenuItem(
                  Icons.lock_outline,
                  'Privacy & Security',
                  'Manage your account privacy',
                ),
                _buildMenuItem(
                  Icons.help_outline,
                  'Help & Support',
                  'Get assistance',
                ),
              ]),

              const SizedBox(height: 25),

              // App Version
              const Center(
                child: Text(
                  'TripMate v1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.charcoal,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
              size: 21,
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
