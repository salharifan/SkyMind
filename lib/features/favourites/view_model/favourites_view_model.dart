import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/db_service.dart';
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
    final exists = state.any(
      (element) => element.cityName.toLowerCase() == cityName.toLowerCase(),
    );

    if (exists) {
      return false;
    }

    await _dbService.insertFavorite(cityName);
    await loadFavorites();
    return true;
  }

  Future<void> removeFavorite(String cityName) async {
    await _dbService.deleteFavorite(cityName);
    await loadFavorites();
  }
}
