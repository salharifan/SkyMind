import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../view_model/forecast_view_model.dart';

class ForecastScreen extends ConsumerStatefulWidget {
  final String city;

  const ForecastScreen({super.key, required this.city});

  @override
  ConsumerState<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(forecastProvider.notifier).getForecast(widget.city),
    );
  }

  @override
  Widget build(BuildContext context) {
    final forecastState = ref.watch(forecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Forecast: ${widget.city}"),
        backgroundColor: Colors.blueAccent,
      ),
      body: forecastState.when(
        data: (forecastList) {
          if (forecastList.isEmpty) {
            return const Center(child: Text("No forecast available"));
          }
          return Column(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.5),
                      ),
                    ),
                    minX: 0,
                    maxX: forecastList.length.toDouble() - 1,
                    minY:
                        forecastList
                            .map((e) => e.temperature)
                            .reduce((a, b) => a < b ? a : b) -
                        5,
                    maxY:
                        forecastList
                            .map((e) => e.temperature)
                            .reduce((a, b) => a > b ? a : b) +
                        5,
                    lineBarsData: [
                      LineChartBarData(
                        spots: forecastList.asMap().entries.map((e) {
                          return FlSpot(e.key.toDouble(), e.value.temperature);
                        }).toList(),
                        isCurved: true,
                        color: Colors.blueAccent,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blueAccent.withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: forecastList.length,
                  itemBuilder: (context, index) {
                    final item = forecastList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          'https://openweathermap.org/img/wn/${item.icon}.png',
                          width: 50,
                          height: 50,
                        ),
                        title: Text(
                          DateFormat(
                            'EEEE, MMM d – h:mm a',
                          ).format(item.dateTime),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(item.description),
                        trailing: Text(
                          "${item.temperature}°C",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
