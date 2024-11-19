import 'package:flutter/material.dart';
import '../features/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _city = 'London';
  String _temperature = 'Loading...';
  String _weatherDescription = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void _fetchWeatherData() async {
    try {
      var weatherData = await WeatherService().getWeather(_city);
      setState(() {
        _temperature = weatherData['main']['temp'].toString();
        _weatherDescription = weatherData['weather'][0]['description'];
      });
    } catch (e) {
      setState(() {
        _temperature = 'Error';
        _weatherDescription = 'Unable to fetch weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather - $_city'),
        backgroundColor: Color(0xFF432E54), // Dark Purple
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_temperature°C',
              style: TextStyle(fontSize: 50, color: Color(0xFF432E54)),
            ),
            Text(
              _weatherDescription,
              style: TextStyle(fontSize: 24, color: Color(0xFF4B4376)), // Muted Indigo
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B4376),
              ),
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
