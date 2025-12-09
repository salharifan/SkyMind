import 'package:hive_flutter/hive_flutter.dart';
import 'favorite_city_model.dart';

abstract class FavoritesDataSource {
  Future<List<FavoriteCity>> getFavorites();
  Future<void> addFavorite(FavoriteCity city);
  Future<void> removeFavorite(String cityName);
}

class FavoritesLocalDataSource implements FavoritesDataSource {
  final Box<FavoriteCity> box;

  FavoritesLocalDataSource(this.box);

  @override
  Future<List<FavoriteCity>> getFavorites() async {
    return box.values.toList();
  }

  @override
  Future<void> addFavorite(FavoriteCity city) async {
    if (!box.values.any((e) => e.cityName == city.cityName)) {
      await box.add(city);
    }
  }

  @override
  Future<void> removeFavorite(String cityName) async {
    final cityToDelete = box.values.firstWhere(
      (element) => element.cityName == cityName,
      orElse: () => FavoriteCity(cityName: ''),
    );
    if (cityToDelete.cityName.isNotEmpty && cityToDelete.isInBox) {
      await cityToDelete.delete();
    }
  }
}
