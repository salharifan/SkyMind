import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/favorite_city_model.dart';
import '../../data/favorites_db.dart';

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((
  ref,
) {
  final box = Hive.box<FavoriteCity>('favorites');
  return FavoritesLocalDataSource(box);
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavoriteCity>>((ref) {
      final dataSource = ref.watch(favoritesLocalDataSourceProvider);
      return FavoritesNotifier(dataSource);
    });

class FavoritesNotifier extends StateNotifier<List<FavoriteCity>> {
  final FavoritesLocalDataSource _dataSource;

  FavoritesNotifier(this._dataSource) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = await _dataSource.getFavorites();
  }

  Future<void> addFavorite(String cityName) async {
    final city = FavoriteCity(cityName: cityName);
    await _dataSource.addFavorite(city);
    await loadFavorites();
  }

  Future<void> removeFavorite(String cityName) async {
    await _dataSource.removeFavorite(cityName);
    await loadFavorites();
  }
}
