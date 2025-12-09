import 'package:dio/dio.dart';
import '../models/forecast_model.dart';

class ForecastApi {
  final Dio _dio = Dio();
  final String apiKey = 'e0e5b78836fa6c482d0cfa6af94ed35a';

  Future<List<ForecastModel>> fetch5DayForecast(String city) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: {'q': city, 'appid': apiKey, 'units': 'metric'},
    );

    final List<dynamic> list = response.data['list'];
    return list.map((e) => ForecastModel.fromJson(e)).toList();
  }
}
