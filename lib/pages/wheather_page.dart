import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather_app/models/wheather_model.dart';
import 'package:wheather_app/services/wheather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherServices =
      WeatherServices(apikey: "8cb9d357a7ce2748a2d977b3b2f5df61");
  Weather? weather;

  fetchWeather() async {
    String cityName = await _weatherServices.getLocation();

    try {
      final lweather = await _weatherServices.getweather(cityName);
      setState(() {
        weather = lweather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/cloud.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/sun rain.json';
      case 'thunderstorm':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/cloud.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Weather", style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: weather == null ? 
      const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )
      : Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(weather?.city ?? "loading city", style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          Lottie.asset(
            getWeatherAnimation(weather?.mainCondition),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(weather?.temperature== null ? "Loading temperatue" : "${weather?.temperature.toDouble()}c", style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 5,
          ),
          Text(weather?.temperature== null ? "Loading Condition" : "${weather?.mainCondition}", style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      )),
    );
  }
}
