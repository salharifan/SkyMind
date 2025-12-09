import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/home_view_model.dart';
import '../model/weather_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../forecast/view/forecast_screen.dart';
import '../../favourites/view_model/favourites_view_model.dart';
import '../../settings/view/settings_screen.dart';
import '../../settings/view_model/settings_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "SkyMind",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final weatherState = ref.watch(weatherProvider);
              return weatherState.maybeWhen(
                data: (weather) {
                  if (weather == null) return const SizedBox.shrink();
                  return IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      final text =
                          "Current weather in ${weather.cityName}: "
                          "${weather.temperature}°C, ${weather.description}. "
                          "Check it out on SkyMind!";
                      Share.share(text);
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "Enter city",
                prefixIcon: const Icon(Icons.location_city),
                filled: true,
                fillColor: Colors.white.withValues(
                  alpha: 0.8,
                ), // Updated for deprecation
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                ref
                    .read(weatherProvider.notifier)
                    .getWeather(_cityController.text);
              },
              icon: const Icon(Icons.search),
              label: const Text("Get Weather"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: weatherState.when(
                data: (weather) {
                  if (weather == null) {
                    return const Center(
                      child: Text(
                        "Search a city",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }
                  return WeatherCard(weather: weather);
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (err, _) => Center(
                  child: Text(
                    "Error: $err",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2), // Glassmorphism effect
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(20), child: col(context)),
    );
  }

  Widget col(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Image.network(
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          width: 100,
          height: 100,
        ),
        Consumer(
          builder: (context, ref, child) {
            final settings = ref.watch(settingsProvider);
            final temp = settings.tempUnit == 'F'
                ? (weather.temperature * 9 / 5) + 32
                : weather.temperature;
            final wind = settings.windSpeedUnit == 'mph'
                ? weather.windSpeed * 2.237
                : weather.windSpeed;

            return Column(
              children: [
                Text(
                  "${temp.toStringAsFixed(1)}°${settings.tempUnit}",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                Text(
                  weather.description.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "💧 ${weather.humidity}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "💨 ${wind.toStringAsFixed(1)} ${settings.windSpeedUnit}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton.icon(
                  onPressed: () {
                    ref
                        .read(favoritesProvider.notifier)
                        .addFavorite(weather.cityName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${weather.cityName} added to favorites"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                  ),
                );
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ForecastScreen(city: weather.cityName),
                  ),
                );
              },
              icon: const Icon(Icons.bar_chart),
              label: const Text("Forecast"),
            ),
          ],
        ),
      ],
    );
  }
}
