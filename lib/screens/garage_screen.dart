import 'package:flutter/material.dart';
import 'garage_service.dart';

class GarageScreen extends StatefulWidget {
  @override
  _GarageScreenState createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  List<dynamic> _garages = [];

  @override
  void initState() {
    super.initState();
    _fetchGarages();
  }

  void _fetchGarages() async {
    try {
      var garageData = await GarageService().getNearbyGarages('your-location');
      setState(() {
        _garages = garageData;
      });
    } catch (e) {
      setState(() {
        _garages = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Garages'),
        backgroundColor: Color(0xFF432E54), // Dark Purple
      ),
      body: ListView.builder(
        itemCount: _garages.length,
        itemBuilder: (context, index) {
          var garage = _garages[index];
          return ListTile(
            title: Text(garage['name']),
            subtitle: Text(garage['vicinity']),
            leading: Icon(Icons.local_gas_station),
          );
        },
      ),
    );
  }
}
