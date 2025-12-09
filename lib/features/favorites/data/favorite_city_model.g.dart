// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCityAdapter extends TypeAdapter<FavoriteCity> {
  @override
  final int typeId = 0;

  @override
  FavoriteCity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCity(
      cityName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
