class ForecastModel {
  final DateTime dateTime;
  final double temperature;
  final String description;
  final String icon;

  ForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
