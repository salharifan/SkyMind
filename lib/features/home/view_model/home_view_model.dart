import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../model/weather_model.dart';

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<WeatherModel?>>(
      (ref) => WeatherNotifier(),
    );

class WeatherNotifier extends StateNotifier<AsyncValue<WeatherModel?>> {
  WeatherNotifier() : super(const AsyncValue.data(null));

  final WeatherApi _api = WeatherApi();

  Future<void> getWeather(String city) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _api.fetchWeatherByCity(city);
      state = AsyncValue.data(weather);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
