import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool alertsEnabled;
  final String tempUnit; // 'C' or 'F'
  final String windSpeedUnit; // 'km/h' or 'mph'

  SettingsState({
    required this.themeMode,
    required this.alertsEnabled,
    required this.tempUnit,
    required this.windSpeedUnit,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? alertsEnabled,
    String? tempUnit,
    String? windSpeedUnit,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      alertsEnabled: alertsEnabled ?? this.alertsEnabled,
      tempUnit: tempUnit ?? this.tempUnit,
      windSpeedUnit: windSpeedUnit ?? this.windSpeedUnit,
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
    : super(
        SettingsState(
          themeMode: ThemeMode.light,
          alertsEnabled: true,
          tempUnit: 'C',
          windSpeedUnit: 'km/h',
        ),
      );

  void toggleTheme(bool isDark) {
    state = state.copyWith(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void toggleAlerts(bool enabled) {
    state = state.copyWith(alertsEnabled: enabled);
  }

  void setTempUnit(String unit) {
    state = state.copyWith(tempUnit: unit);
  }

  void setWindSpeedUnit(String unit) {
    state = state.copyWith(windSpeedUnit: unit);
  }
}
