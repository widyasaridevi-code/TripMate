
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DestinationDetailScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState
    extends State<DestinationDetailScreen> {
  static const String _favoritesKey = 'explore_favorites';

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    if (mounted) {
      setState(() {
        isFavorite = favorites.contains(widget.destination['name']);
      });
    }
  }

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    final name = widget.destination['name'] as String;

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      if (!favorites.contains(name)) {
        favorites.add(name);
      }
    } else {
      favorites.remove(name);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                destination['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.softSage,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: toggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination['name'],
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          destination['location'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        destination['rating'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'About Destination',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Discover the beauty of ${destination['name']}, '
                    'a wonderful destination located in '
                    '${destination['location']}. '
                    'Enjoy its unique atmosphere, explore interesting '
                    'places, and create unforgettable travel memories.',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Destination Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _infoRow(
                    Icons.category_outlined,
                    'Category',
                    destination['category'] ?? 'Destination',
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.star_outline,
                    'Rating',
                    '${destination['rating']} / 5.0',
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.location_on_outlined,
                    'Location',
                    destination['location'],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: toggleFavorite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 10),
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
