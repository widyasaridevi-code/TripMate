
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/weather_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/weather_info.dart';
import 'destination_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const String _favoritesKey = 'explore_favorites';

  String selectedCategory = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Ubud',
      'location': 'Bali, Indonesia',
      'category': 'Nature',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=600',
    },
    {
      'name': 'Raja Ampat',
      'location': 'West Papua, Indonesia',
      'category': 'Beach',
      'rating': '5.0',
      'image':
          'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=600',
    },
    {
      'name': 'Mount Bromo',
      'location': 'East Java, Indonesia',
      'category': 'Mountain',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=600',
    },
    {
      'name': 'Jakarta',
      'location': 'DKI Jakarta, Indonesia',
      'category': 'City',
      'rating': '4.7',
      'image':
          'https://images.unsplash.com/photo-1538970272646-f61fabb3a8a2?w=600',
    },
  ];

  final Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    loadFavorites();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<WeatherProvider>().loadWeather();
      }
    });
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites = prefs.getStringList(_favoritesKey) ?? [];

    if (mounted) {
      setState(() {
        favorites
          ..clear()
          ..addAll(savedFavorites);
      });
    }
  }

  Future<void> toggleFavorite(String name) async {
    setState(() {
      if (favorites.contains(name)) {
        favorites.remove(name);
      } else {
        favorites.add(name);
      }
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _favoritesKey,
      favorites.toList(),
    );
  }

  void openDestinationDetail(Map<String, dynamic> destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DestinationDetailScreen(
          destination: destination,
        ),
      ),
    ).then((_) {
      loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    final filteredDestinations = destinations.where((destination) {
      final matchesCategory = selectedCategory == 'All' ||
          destination['category'] == selectedCategory;

      final matchesSearch = destination['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          destination['location']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover Places',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Find your next adventure.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 22),

              // Search
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
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

              const SizedBox(height: 25),

              // Categories
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 15),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'All',
                    'Beach',
                    'Mountain',
                    'Nature',
                    'City',
                  ].map((category) {
                    final isSelected = selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.charcoal,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 25),

              // Destination list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Destinations',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  Text(
                    '${filteredDestinations.length} places',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (filteredDestinations.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'No destinations found.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount =
                        constraints.maxWidth >= 700 ? 2 : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredDestinations.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 18,
                        mainAxisExtent: 310,
                      ),
                      itemBuilder: (context, index) {
                        final destination = filteredDestinations[index];
                        final name = destination['name'] as String;
                        final isFavorite = favorites.contains(name);
                        final weather =
                            weatherProvider.weatherData[name];

                        return GestureDetector(
                          onTap: () {
                            openDestinationDetail(destination);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          const BorderRadius.vertical(
                                        top: Radius.circular(18),
                                      ),
                                      child: Image.network(
                                        destination['image'],
                                        height: 170,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 170,
                                            color: AppColors.softSage,
                                            child: const Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            toggleFavorite(name);
                                          },
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.charcoal,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                destination['location'],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              WeatherInfo(
                                                weather: weather,
                                                isLoading:
                                                    weatherProvider.isLoading,
                                                errorMessage:
                                                    weatherProvider.errorMessage,
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
                                          destination['rating'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.charcoal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
