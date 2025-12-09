import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/favourites_model.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavouritesModel>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<FavouritesModel>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final box = Hive.box<FavouritesModel>('favorites');
    state = box.values.toList();
  }

  Future<bool> addFavorite(String cityName) async {
    final box = Hive.box<FavouritesModel>('favorites');

    // Check for duplicate
    final exists = box.values.any(
      (element) => element.cityName.toLowerCase() == cityName.toLowerCase(),
    );

    if (exists) {
      return false; // Already exists
    }

    final city = FavouritesModel(cityName: cityName);
    await box.add(city);
    await loadFavorites();
    return true; // Added successfully
  }

  Future<void> removeFavorite(String cityName) async {
    final box = Hive.box<FavouritesModel>('favorites');
    final key = box.values.toList().indexWhere(
      (element) => element.cityName == cityName,
    );
    if (key != -1) {
      await box.deleteAt(key);
      await loadFavorites();
    }
  }
}
