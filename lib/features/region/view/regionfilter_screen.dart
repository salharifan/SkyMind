import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/view_model/home_view_model.dart';

class RegionFilterScreen extends ConsumerStatefulWidget {
  const RegionFilterScreen({super.key});

  @override
  ConsumerState<RegionFilterScreen> createState() => _RegionFilterScreenState();
}

class _RegionFilterScreenState extends ConsumerState<RegionFilterScreen> {
  final List<Map<String, String>> regions = [
    {'name': 'Asia', 'cities': 'Tokyo, Beijing, Mumbai, Seoul, Bangkok'},
    {'name': 'Europe', 'cities': 'London, Paris, Berlin, Rome, Madrid'},
    {
      'name': 'North America',
      'cities': 'New York, Los Angeles, Chicago, Toronto, Mexico City',
    },
    {
      'name': 'South America',
      'cities': 'São Paulo, Buenos Aires, Rio de Janeiro, Lima, Bogotá',
    },
    {
      'name': 'Africa',
      'cities': 'Cairo, Lagos, Johannesburg, Nairobi, Casablanca',
    },
    {
      'name': 'Oceania',
      'cities': 'Sydney, Melbourne, Auckland, Brisbane, Perth',
    },
  ];

  final List<String> popularCities = [
    'London',
    'New York',
    'Tokyo',
    'Paris',
    'Dubai',
    'Singapore',
    'Hong Kong',
    'Los Angeles',
    'Sydney',
    'Toronto',
    'Mumbai',
    'Berlin',
    'Rome',
    'Madrid',
    'Amsterdam',
  ];

  void _loadWeather(String city) {
    ref.read(weatherProvider.notifier).getWeather(city);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Loading weather for $city...'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          "Filter by Region",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Popular Cities Section
            Card(
              elevation: 5,
              shadowColor: Colors.blueAccent.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Popular Cities',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: popularCities.map((city) {
                        return Chip(
                          elevation: 3,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          backgroundColor: Colors.blue.shade50,
                          avatar: const Icon(Icons.location_city, size: 18),
                          label: Text(city),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onDeleted: () => _loadWeather(city),
                          deleteIcon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          deleteIconColor: Colors.blueAccent,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Regions Section
            Text(
              'Browse by Region',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            ...regions.map((region) {
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                elevation: 4,
                shadowColor: Colors.blueAccent.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Colors.blueAccent,
                    collapsedIconColor: Colors.blueAccent,
                    leading: Icon(Icons.public, color: Colors.blueAccent),
                    title: Text(
                      region['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Major Cities",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: region['cities']!.split(', ').map((
                                city,
                              ) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _loadWeather(city),
                                  child: Text(
                                    city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
