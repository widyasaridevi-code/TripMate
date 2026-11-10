
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static const String _favoritesKey = 'explore_favorites';

  late Future<List<String>> _favoritesFuture;

  final List<Map<String, String>> destinations = const [
    {
      'name': 'Ubud',
      'location': 'Bali, Indonesia',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=600',
    },
    {
      'name': 'Raja Ampat',
      'location': 'West Papua, Indonesia',
      'rating': '5.0',
      'image':
          'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=600',
    },
    {
      'name': 'Mount Bromo',
      'location': 'East Java, Indonesia',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=600',
    },
    {
      'name': 'Jakarta',
      'location': 'DKI Jakarta, Indonesia',
      'rating': '4.7',
      'image':
          'https://images.unsplash.com/photo-1538970272646-f61fabb3a8a2?w=600',
    },
  ];

  @override
  void initState() {
    super.initState();
    _favoritesFuture = loadFavorites();
  }

  Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> removeFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    favorites.remove(name);
    await prefs.setStringList(_favoritesKey, favorites);

    if (!mounted) return;

    setState(() {
      _favoritesFuture = Future.value(favorites);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FutureBuilder<List<String>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final favoriteNames = snapshot.data ?? [];

            final favoriteDestinations = destinations
                .where(
                  (destination) =>
                      favoriteNames.contains(destination['name']),
                )
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Favorites',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your favorite places in one collection.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Saved Destinations',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColors.charcoal,
                        ),
                      ),
                      Text(
                        '${favoriteDestinations.length} places',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (favoriteDestinations.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 45,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No favorites yet.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.charcoal,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Explore destinations and tap the heart to save them here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...favoriteDestinations.map((destination) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                              child: Image.network(
                                destination['image']!,
                                height: 170,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    height: 170,
                                    color: AppColors.softSage,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          destination['name']!,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.charcoal,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 14,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              destination['location']!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    destination['rating']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.charcoal,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      removeFavorite(
                                        destination['name']!,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
