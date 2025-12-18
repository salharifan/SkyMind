import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../alerts/view_model/alerts_view_model.dart';
import '../../../core/services/api_service.dart';
import '../model/weather_model.dart';

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<WeatherModel?>>(
      (ref) => WeatherNotifier(ref),
    );

class WeatherNotifier extends StateNotifier<AsyncValue<WeatherModel?>> {
  final Ref ref;
  WeatherNotifier(this.ref) : super(const AsyncValue.data(null));

  final WeatherApi _api = WeatherApi();

  Future<void> getWeather(String city) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _api.fetchWeatherByCity(city);
      state = AsyncValue.data(weather);

      // Trigger a local alert for the searched city
      await ref
          .read(alertsProvider.notifier)
          .addAlert(
            "Search: ${weather.cityName}",
            "Weather fetched: ${weather.temperature}°C, ${weather.description}.",
          );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
