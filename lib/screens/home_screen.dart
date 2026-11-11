
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/category_item.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Traveler!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Where to next?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.softSage,
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Search
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search destinations...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Categories
              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CategoryItem(
                    icon: Icons.beach_access,
                    label: 'Beach',
                  ),
                  CategoryItem(
                    icon: Icons.terrain,
                    label: 'Mountain',
                  ),
                  CategoryItem(
                    icon: Icons.forest,
                    label: 'Nature',
                  ),
                  CategoryItem(
                    icon: Icons.location_city,
                    label: 'City',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Featured destination
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=1000',
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          color: AppColors.softSage,
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 15,
                      right: 15,
                      bottom: 15,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bali, Indonesia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Island of Paradise',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Popular destinations
              const Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DestinationCard(
                      name: 'Ubud',
                      country: 'Bali, Indonesia',
                      imageUrl:
                          'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=600',
                    ),
                    SizedBox(width: 15),
                    DestinationCard(
                      name: 'Raja Ampat',
                      country: 'West Papua, Indonesia',
                      imageUrl:
                          'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=600',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
