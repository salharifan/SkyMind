import 'package:hive/hive.dart';

class FavouritesModel extends HiveObject {
  final String cityName;

  FavouritesModel({required this.cityName});
}

class FavouritesModelAdapter extends TypeAdapter<FavouritesModel> {
  @override
  final int typeId = 0;

  @override
  FavouritesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritesModel(cityName: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, FavouritesModel obj) {
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
      other is FavouritesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
