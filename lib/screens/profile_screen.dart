
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

  Future<void> editProfile() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return EditProfileDialog(
          name: userName,
          email: userEmail,
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        userName = result['name']!;
        userEmail = result['email']!;
      });
    }
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
                      child: Text(
                        userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userEmail.isEmpty
                          ? 'Travel Enthusiast'
                          : userEmail,
                      style: const TextStyle(
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
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: editProfile,
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(
                            color: AppColors.primary,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              _buildSectionTitle('Personal Information'),
              const SizedBox(height: 12),

              _buildInfoCard([
                _buildMenuItem(
                  Icons.person_outline,
                  'Full Name',
                  userName,
                ),
                _buildMenuItem(
                  Icons.email_outlined,
                  'Email Address',
                  userEmail.isEmpty ? 'Not added yet' : userEmail,
                ),
                _buildMenuItem(
                  Icons.location_on_outlined,
                  'Country',
                  'Indonesia',
                ),
              ]),

              const SizedBox(height: 25),

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
      child: Column(children: children),
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

// Edit Profile Dialog
class EditProfileDialog extends StatefulWidget {
  final String name;
  final String email;

  const EditProfileDialog({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<EditProfileDialog> createState() =>
      _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveProfile() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields.'),
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'name': name,
      'email': email,
    });
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
            const SizedBox(height: 15),
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
          onPressed: saveProfile,
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
