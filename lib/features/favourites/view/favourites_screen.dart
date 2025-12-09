import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/favourites_view_model.dart';
import '../../home/view_model/home_view_model.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

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
                  confirmDismiss: (_) async {
                    return await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Favorite?"),
                        content: Text(
                          "Are you sure you want to remove ${city.cityName}?",
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(ctx, false),
                          ),
                          TextButton(
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () => Navigator.pop(ctx, true),
                          ),
                        ],
                      ),
                    );
                  },
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
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Delete Favorite?"),
                              content: Text(
                                "Are you sure you want to remove ${city.cityName}?",
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.pop(ctx, false),
                                ),
                                TextButton(
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Navigator.pop(ctx, true),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            ref
                                .read(favoritesProvider.notifier)
                                .removeFavorite(city.cityName);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${city.cityName} removed"),
                                ),
                              );
                            }
                          }
                        },
                      ),

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
