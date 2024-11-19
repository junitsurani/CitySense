import 'package:flutter/material.dart';
import './traffic_screen.dart';

class TrafficScreen extends StatefulWidget {
  @override
  _TrafficScreenState createState() => _TrafficScreenState();
}

class _TrafficScreenState extends State<TrafficScreen> {
  String _trafficCondition = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchTrafficData();
  }

  void _fetchTrafficData() async {
    try {
      var trafficData = await TrafficService().getTrafficData('your-location');
      setState(() {
        _trafficCondition = trafficData['condition'];
      });
    } catch (e) {
      setState(() {
        _trafficCondition = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Conditions'),
        backgroundColor: Color(0xFF432E54), // Dark Purple
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Traffic Condition: $_trafficCondition',
              style: TextStyle(fontSize: 24, color: Color(0xFF4B4376)), // Muted Indigo
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchTrafficData,
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
