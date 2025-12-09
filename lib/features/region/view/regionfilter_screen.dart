import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/view_model/home_view_model.dart';
import '../view_model/regionfilter_view_model.dart';

class RegionFilterScreen extends ConsumerStatefulWidget {
  const RegionFilterScreen({super.key});

  @override
  ConsumerState<RegionFilterScreen> createState() => _RegionFilterScreenState();
}

class _RegionFilterScreenState extends ConsumerState<RegionFilterScreen> {
  final TextEditingController _searchController = TextEditingController();

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

    // We are in a tab, so we don't pop. We just notify.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Weather loaded for $city. Check Home tab!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Go to Home',
          onPressed: () {
            // Ideally we would switch tab here, but for now just letting user know.
            // Accessing ancestor state is fragile without context or riverpod for tab state.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final regionViewModel = ref.watch(regionFilterProvider);
    final allRegions = regionViewModel.regions;

    // Filter logic
    final query = _searchController.text.toLowerCase();
    final displayedRegions = allRegions.where((region) {
      return region.regionName.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Filter by Region",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search Region...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Popular Cities Section - Only show if not searching or if requested?
                  // Let's keep it but maybe hide if search doesn't match?
                  // The user specifically asked to type REGION. So filtering regions is key.
                  if (query.isEmpty) ...[
                    Card(
                      elevation: 5,
                      shadowColor: Colors.blueAccent.withValues(alpha: 0.2),
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
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 28,
                                ),
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
                                  avatar: const Icon(
                                    Icons.location_city,
                                    size: 18,
                                  ),
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
                    Text(
                      'Browse by Region',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (displayedRegions.isEmpty && query.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("No regions found matching your search."),
                      ),
                    ),

                  ...displayedRegions.map((region) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      elevation: 4,
                      shadowColor: Colors.blueAccent.withValues(alpha: 0.15),
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
                            region.regionName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          initiallyExpanded:
                              query.isNotEmpty, // Auto expand when searching

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
                                    children: region.cities.map((city) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
          ),
        ],
      ),
    );
  }
}
