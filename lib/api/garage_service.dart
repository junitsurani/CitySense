import 'dart:convert';
import 'package:http/http.dart' as http;

class GarageService {
  static const String _apiKey = 'YOUR_API_KEY'; // Replace with your API key
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  Future<List<dynamic>> getNearbyGarages(String location) async {
    final url = Uri.parse('$_baseUrl?location=$location&type=garage&radius=5000&key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load garages');
    }
  }
}
