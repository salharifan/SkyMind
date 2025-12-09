import 'package:dio/dio.dart';
import '../../features/home/model/weather_model.dart';
import '../../features/forecast/model/forecast_model.dart';

class WeatherApi {
  final Dio _dio = Dio();
  final String apiKey = 'e0e5b78836fa6c482d0cfa6af94ed35a';

  Future<WeatherModel> fetchWeatherByCity(String city) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {'q': city, 'appid': apiKey, 'units': 'metric'},
    );

    final data = response.data;

    return WeatherModel(
      cityName: data['name'],
      temperature: (data['main']['temp'] as num).toDouble(),
      minTemp: (data['main']['temp_min'] as num).toDouble(),
      maxTemp: (data['main']['temp_max'] as num).toDouble(),
      description: data['weather'][0]['description'],
      icon: data['weather'][0]['icon'],
      humidity: (data['main']['humidity'] as num).toInt(),
      windSpeed: (data['wind']['speed'] as num).toDouble(),
    );
  }
}

class ForecastApi {
  final Dio _dio = Dio();
  final String apiKey = 'e0e5b78836fa6c482d0cfa6af94ed35a';

  Future<List<ForecastModel>> fetch5DayForecast(String city) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: {'q': city, 'appid': apiKey, 'units': 'metric'},
    );

    final List<dynamic> list = response.data['list'];
    return list.map((item) => ForecastModel.fromJson(item)).toList();
  }
}
