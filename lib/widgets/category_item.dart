
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.softSage,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.charcoal,
          ),
        ),
      ],
    );
  }
}
