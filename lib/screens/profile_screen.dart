
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Komang Widyasari Devi';
  String userEmail = '';

  String favoriteDestination = 'Not selected';
  String travelStyle = 'Not selected';

  bool notificationsEnabled = true;
  bool profileVisibility = true;
  bool locationSharing = false;

  final List<String> destinations = [
    'Bali',
    'Yogyakarta',
    'Raja Ampat',
    'Lombok',
    'Bandung',
    'Jakarta',
  ];

  final List<String> travelStyles = [
    'Adventure',
    'Relaxing',
    'Cultural',
    'Nature',
    'Luxury',
    'Budget Friendly',
  ];

  Future<void> editProfile() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return EditProfileDialog(
          currentName: userName,
          currentEmail: userEmail,
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        userName = result['name'] ?? userName;
        userEmail = result['email'] ?? userEmail;
      });
    }
  }

  Future<void> selectPreference({
    required String title,
    required List<String> options,
    required String currentValue,
    required bool isDestination,
  }) async {
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        String selectedValue = currentValue == 'Not selected'
            ? options.first
            : currentValue;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: RadioGroup<String>(
                  groupValue: selectedValue,
                  onChanged: (String? value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedValue = value;
                      });
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((option) {
                      return RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, selectedValue);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        if (isDestination) {
          favoriteDestination = result;
        } else {
          travelStyle = result;
        }
      });
    }
  }

  void openPrivacySettings() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Privacy & Security'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Profile Visibility'),
                    subtitle: Text(
                      profileVisibility
                          ? 'Your profile is visible'
                          : 'Your profile is hidden',
                    ),
                    activeThumbColor: AppColors.primary,
                    value: profileVisibility,
                    onChanged: (value) {
                      setDialogState(() {
                        profileVisibility = value;
                      });
                      setState(() {
                        profileVisibility = value;
                      });
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Location Sharing'),
                    subtitle: Text(
                      locationSharing
                          ? 'Location sharing is enabled'
                          : 'Location sharing is disabled',
                    ),
                    activeThumbColor: AppColors.primary,
                    value: locationSharing,
                    onChanged: (value) {
                      setDialogState(() {
                        locationSharing = value;
                      });
                      setState(() {
                        locationSharing = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                'My Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 20),

              _buildProfileCard(),

              const SizedBox(height: 28),

              _buildSectionTitle('Personal Information'),
              const SizedBox(height: 12),
              _buildInfoCard(
                icon: Icons.person_outline,
                title: 'Full Name',
                value: userName,
              ),
              _buildInfoCard(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: userEmail.isEmpty ? 'Not added yet' : userEmail,
              ),
              _buildInfoCard(
                icon: Icons.flag_outlined,
                title: 'Country',
                value: 'Indonesia',
              ),

              const SizedBox(height: 28),

              _buildSectionTitle('Travel Preferences'),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Favorite Destination',
                subtitle: favoriteDestination == 'Not selected'
                    ? 'Explore your favorite places'
                    : favoriteDestination,
                onTap: () {
                  selectPreference(
                    title: 'Choose Favorite Destination',
                    options: destinations,
                    currentValue: favoriteDestination,
                    isDestination: true,
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.flight_takeoff_outlined,
                title: 'Travel Style',
                subtitle: travelStyle == 'Not selected'
                    ? 'Discover your travel style'
                    : travelStyle,
                onTap: () {
                  selectPreference(
                    title: 'Choose Travel Style',
                    options: travelStyles,
                    currentValue: travelStyle,
                    isDestination: false,
                  );
                },
              ),

              const SizedBox(height: 28),

              _buildSectionTitle('Settings'),
              const SizedBox(height: 12),

              _buildNotificationItem(),

              _buildMenuItem(
                icon: Icons.lock_outline,
                title: 'Privacy & Security',
                subtitle: 'Manage your account privacy',
                onTap: openPrivacySettings,
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help with TripMate',
              ),

              const SizedBox(height: 28),

              Center(
                child: Text(
                  'TripMate v1.0.0',
                  style: TextStyle(
                    color: AppColors.charcoal.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: AppColors.softSage,
            child: Text(
              userName.isNotEmpty
                  ? userName.trim().split(' ').map((e) => e[0]).take(2).join()
                  : 'TM',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail.isEmpty ? 'Travel Enthusiast' : userEmail,
            style: TextStyle(
              color: AppColors.charcoal.withValues(alpha: 0.6),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.softSage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'TripMate Member',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: editProfile,
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors.charcoal,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.charcoal.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

  Widget _buildNotificationItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_none,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notificationsEnabled
                      ? 'Notifications are on'
                      : 'Notifications are off',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.charcoal.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: notificationsEnabled,
            activeThumbColor: AppColors.primary,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.charcoal.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.charcoal,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileDialog extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileDialog({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email_outlined),
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
          onPressed: () {
            Navigator.pop(
              context,
              {
                'name': nameController.text.trim(),
                'email': emailController.text.trim(),
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
