import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/forecast_provider.dart';

class ForecastPage extends ConsumerStatefulWidget {
  final String city;

  const ForecastPage({super.key, required this.city});

  @override
  ConsumerState<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends ConsumerState<ForecastPage> {
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
          return ListView.builder(
            itemCount: forecastList.length,
            itemBuilder: (context, index) {
              final item = forecastList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    DateFormat('EEEE, MMM d – h:mm a').format(item.dateTime),
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
