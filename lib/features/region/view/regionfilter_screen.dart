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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter by Region"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Popular Cities Section
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Popular Cities',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: popularCities.map((city) {
                      return ActionChip(
                        label: Text(city),
                        avatar: const Icon(Icons.location_city, size: 18),
                        onPressed: () {
                          ref.read(weatherProvider.notifier).getWeather(city);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Loading weather for $city...'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

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
              margin: const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
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
                          'Major Cities:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: region['cities']!.split(', ').map((city) {
                            return OutlinedButton(
                              onPressed: () {
                                ref
                                    .read(weatherProvider.notifier)
                                    .getWeather(city);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Loading weather for $city...',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Text(city),
                            );
                          }).toList(),
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
  }
}
