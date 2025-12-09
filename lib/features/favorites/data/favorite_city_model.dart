import 'package:hive/hive.dart';

part 'favorite_city_model.g.dart';

@HiveType(typeId: 0)
class FavoriteCity extends HiveObject {
  @HiveField(0)
  final String cityName;

  FavoriteCity({required this.cityName});
}
