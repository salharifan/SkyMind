import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/alert_model.dart';

class AlertsViewModel extends StateNotifier<List<AlertModel>> {
  AlertsViewModel() : super([]);

  void addAlert(AlertModel alert) {
    state = [...state, alert];
  }

  void removeAlert(int index) {
    state = [...state]..removeAt(index);
  }

  void clearAlerts() {
    state = [];
  }
}

final alertsProvider = StateNotifierProvider<AlertsViewModel, List<AlertModel>>(
  (ref) => AlertsViewModel(),
);
