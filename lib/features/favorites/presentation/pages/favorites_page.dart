import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/favorites_provider.dart';
import '../../../home/presentation/providers/weather_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Cities"),
        backgroundColor: Colors.blueAccent,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorite cities added yet."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final city = favorites[index];
                return Dismissible(
                  key: Key(city.cityName),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    ref
                        .read(favoritesProvider.notifier)
                        .removeFavorite(city.cityName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${city.cityName} removed")),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(city.cityName),
                      leading: const Icon(Icons.location_city),
                      onTap: () {
                        // When tapping a favorite, fetch weather for it and go back
                        ref
                            .read(weatherProvider.notifier)
                            .getWeather(city.cityName);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
