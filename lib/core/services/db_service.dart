import 'package:hive_flutter/hive_flutter.dart';
import '../../features/favourites/model/favourites_model.dart';

abstract class FavoritesDataSource {
  Future<List<FavouritesModel>> getFavorites();
  Future<void> addFavorite(FavouritesModel city);
  Future<void> removeFavorite(String cityName);
}

class FavoritesLocalDataSource implements FavoritesDataSource {
  final Box<FavouritesModel> box;

  FavoritesLocalDataSource(this.box);

  @override
  Future<List<FavouritesModel>> getFavorites() async {
    return box.values.toList();
  }

  @override
  Future<void> addFavorite(FavouritesModel city) async {
    if (!box.values.any((e) => e.cityName == city.cityName)) {
      await box.add(city);
    }
  }

  @override
  Future<void> removeFavorite(String cityName) async {
    final cityToDelete = box.values.firstWhere(
      (element) => element.cityName == cityName,
      orElse: () => FavouritesModel(cityName: ''),
    );
    if (cityToDelete.cityName.isNotEmpty && cityToDelete.isInBox) {
      await cityToDelete.delete();
    }
  }
}
