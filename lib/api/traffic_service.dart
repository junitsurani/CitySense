import 'dart:convert';
import 'package:http/http.dart' as http;

class TrafficService {
  static const String _apiKey = 'YOUR_API_KEY'; // Replace with your API key
  static const String _baseUrl = 'https://api.tomtom.com/traffic/services';

  Future<Map<String, dynamic>> getTrafficData(String location) async {
    final url = Uri.parse('$_baseUrl?location=$location&apikey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load traffic data');
    }
  }
}
