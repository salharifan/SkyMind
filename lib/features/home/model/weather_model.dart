class WeatherModel {
  final String cityName;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  cityName: json['cityName'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  minTemp: (json['minTemp'] as num).toDouble(),
  maxTemp: (json['maxTemp'] as num).toDouble(),
  description: json['description'] as String,
  icon: json['icon'] as String,
  humidity: (json['humidity'] as num?)?.toInt() ?? 0,
  windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'description': instance.description,
      'icon': instance.icon,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
    };
