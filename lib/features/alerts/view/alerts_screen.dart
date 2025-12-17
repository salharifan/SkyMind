import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/alert_model.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  DateTimeRange? _selectedDateRange;

  Future<void> _pickDateRange() async {
    // final DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _clearFilter() {
    setState(() {
      _selectedDateRange = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Alerts"),
        actions: [
          IconButton(
            icon: Icon(
              _selectedDateRange == null
                  ? Icons.filter_alt_outlined
                  : Icons.filter_alt,
            ),
            tooltip: "Filter by Date",
            onPressed: _pickDateRange,
          ),
          if (_selectedDateRange != null)
            IconButton(
              icon: const Icon(Icons.filter_alt_off),
              tooltip: "Clear Filter",
              onPressed: _clearFilter,
            ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: "Clear All Alerts",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Clear All Alerts?"),
                  content: const Text(
                    "This feature is temporarily disabled during migration.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedDateRange != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    "Filtering: ${DateFormat('MMM dd').format(_selectedDateRange!.start)} - ${DateFormat('MMM dd').format(_selectedDateRange!.end)}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Builder(
              builder: (context) {
                // Mock data since Hive is removed and we haven't implemented Sqflite for Alerts yet
                var alerts = [
                  AlertModel(
                    title: "Heavy Rain",
                    message: "Heavy rain expected in London this evening.",
                    dateTime: DateTime.now(),
                  ),
                  AlertModel(
                    title: "High Wind",
                    message: "Strong winds in Tokyo tomorrow morning.",
                    dateTime: DateTime.now().add(const Duration(days: 1)),
                  ),
                  AlertModel(
                    title: "Heat Wave",
                    message: "Extreme heat warning for Dubai.",
                    dateTime: DateTime.now().subtract(const Duration(hours: 5)),
                  ),
                ];

                // Sort by date descending
                alerts.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                // Apply filter
                if (_selectedDateRange != null) {
                  alerts = alerts.where((alert) {
                    return alert.dateTime.isAfter(
                          _selectedDateRange!.start.subtract(
                            const Duration(seconds: 1),
                          ),
                        ) &&
                        alert.dateTime.isBefore(
                          _selectedDateRange!.end.add(const Duration(days: 1)),
                        );
                  }).toList();
                }

                if (alerts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No alerts at this time.",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final isDark = Theme.of(context).brightness == Brightness.dark;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: alerts.length,
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [Colors.grey[800]!, Colors.grey[900]!]
                              : [Colors.orange.shade50, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            // detailed view if needed
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.orangeAccent.withValues(
                                            alpha: 0.2,
                                          )
                                        : Colors.orange.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.warning_rounded,
                                    color: isDark
                                        ? Colors.orangeAccent
                                        : Colors.deepOrange,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            alert.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            DateFormat(
                                              'MMM d, h:mm a',
                                            ).format(alert.dateTime),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark
                                                  ? Colors.grey[500]
                                                  : Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        alert.message,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
