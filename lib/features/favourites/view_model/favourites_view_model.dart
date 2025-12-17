import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/db_service.dart';
import '../model/favourites_model.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavouritesModel>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<FavouritesModel>> {
  final DatabaseService _dbService = DatabaseService();

  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final cityNames = await _dbService.getFavorites();
    state = cityNames.map((name) => FavouritesModel(cityName: name)).toList();
  }

  Future<bool> addFavorite(String cityName) async {
    // Check for duplicate locally first to avoid unnecessary DB calls if strict uniqueness logic is needed immediately
    // Or rely on DB Constraints. Here we check logic similar to before.
    final exists = state.any(
      (element) => element.cityName.toLowerCase() == cityName.toLowerCase(),
    );

    if (exists) {
      return false; // Already exists
    }

    await _dbService.insertFavorite(cityName);
    await loadFavorites();
    return true; // Added successfully
  }

  Future<void> removeFavorite(String cityName) async {
    await _dbService.deleteFavorite(cityName);
    await loadFavorites();
  }
}
