class Weather {
  final String city;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.city,
    required this.mainCondition,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      mainCondition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
