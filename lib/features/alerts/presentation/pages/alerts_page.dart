import 'package:flutter/material.dart';
import '../../data/alert_model.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder alerts - in a real app these typically come from a local database or API
    final List<AlertModel> alerts = [
      AlertModel(
        title: "Storm Warning",
        message: "Heavy thunderstorm expected in the evening.",
        dateTime: DateTime.now(),
      ),
      AlertModel(
        title: "Heat Advisory",
        message: "Extreme heat expected tomorrow. Stay hydrated.",
        dateTime: DateTime.now().add(const Duration(days: 1)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Weather Alerts")),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            color: Colors.orange[50],
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.deepOrange,
              ),
              title: Text(
                alert.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.message),
                  const SizedBox(height: 5),
                  Text(
                    "${alert.dateTime.day}/${alert.dateTime.month} ${alert.dateTime.hour}:${alert.dateTime.minute}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
