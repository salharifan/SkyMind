import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/forecast_model.dart';
import '../../data/data_sources/forecast_api.dart';

final forecastProvider =
    StateNotifierProvider<ForecastNotifier, AsyncValue<List<ForecastModel>>>((
      ref,
    ) {
      return ForecastNotifier();
    });

class ForecastNotifier extends StateNotifier<AsyncValue<List<ForecastModel>>> {
  ForecastNotifier() : super(const AsyncValue.loading());

  final ForecastApi _api = ForecastApi();

  Future<void> getForecast(String city) async {
    state = const AsyncValue.loading();
    try {
      final forecast = await _api.fetch5DayForecast(city);
      state = AsyncValue.data(forecast);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
