import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/db_service.dart';
import '../model/alert_model.dart';

class AlertsViewModel extends StateNotifier<List<AlertModel>> {
  final DatabaseService _dbService = DatabaseService();

  AlertsViewModel() : super([]) {
    loadAlerts();
  }

  Future<void> loadAlerts() async {
    final List<Map<String, dynamic>> maps = await _dbService.getAlerts();
    state = maps.map((map) {
      return AlertModel(
        title: map['title'] as String,
        message: map['message'] as String,
        dateTime: DateTime.parse(map['dateTime'] as String),
      );
    }).toList();
  }

  Future<void> addAlert(String title, String message) async {
    final now = DateTime.now();
    await _dbService.insertAlert(title, message, now);
    await loadAlerts();
  }

  Future<void> clearAlerts() async {
    await _dbService.clearAllAlerts();
    state = [];
  }
}

final alertsProvider = StateNotifierProvider<AlertsViewModel, List<AlertModel>>(
  (ref) => AlertsViewModel(),
);
