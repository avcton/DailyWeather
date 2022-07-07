import 'package:flutter/material.dart';
import 'Screens/weather_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Weather',
      home: WeatherPage(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
