import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final isDark = settingsState.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blueAccent,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable dark theme for the app"),
            value: isDark,
            onChanged: (val) {
              ref.read(settingsProvider.notifier).toggleTheme(val);
            },
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Weather Alerts"),
            subtitle: const Text("Receive notifications for weather updates"),
            value: settingsState.alertsEnabled,
            onChanged: (val) {
              ref.read(settingsProvider.notifier).toggleAlerts(val);
            },
            secondary: const Icon(Icons.notifications),
          ),
          const Divider(),
          ListTile(
            title: const Text("Temperature Unit"),
            subtitle: const Text("Select Fahrenheit or Celsius"),
            leading: const Icon(Icons.thermostat),
            trailing: DropdownButton<String>(
              value: settingsState.tempUnit,
              items: const [
                DropdownMenuItem(value: 'C', child: Text("Celsius (°C)")),
                DropdownMenuItem(value: 'F', child: Text("Fahrenheit (°F)")),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref.read(settingsProvider.notifier).setTempUnit(val);
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Wind Speed Unit"),
            subtitle: const Text("Select km/h or mph"),
            leading: const Icon(Icons.air),
            trailing: DropdownButton<String>(
              value: settingsState.windSpeedUnit,
              items: const [
                DropdownMenuItem(value: 'km/h', child: Text("km/h")),
                DropdownMenuItem(value: 'mph', child: Text("mph")),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref.read(settingsProvider.notifier).setWindSpeedUnit(val);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
