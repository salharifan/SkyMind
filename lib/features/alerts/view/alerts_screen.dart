import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/alert_model.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Alerts")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<AlertModel>('alerts').listenable(),
        builder: (context, Box<AlertModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No alerts at this time."));
          }

          final alerts = box.values.toList();
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Card(
                color: isDark ? Colors.grey[800] : Colors.orange[50],
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_rounded,
                    color: isDark ? Colors.orangeAccent : Colors.deepOrange,
                  ),
                  title: Text(
                    alert.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.message,
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${alert.dateTime.day}/${alert.dateTime.month} ${alert.dateTime.hour}:${alert.dateTime.minute}",
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
