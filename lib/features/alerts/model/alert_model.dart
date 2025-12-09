import 'package:hive/hive.dart';

part 'alert_model.g.dart';

@HiveType(typeId: 1)
class AlertModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime dateTime;

  AlertModel({
    required this.title,
    required this.message,
    required this.dateTime,
  });
}
