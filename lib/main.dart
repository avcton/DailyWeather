import 'package:daily_weather/Packages/notification_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHandler().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Weather',
      home: WeatherPage(),
      theme: ThemeData(
          textTheme: TextTheme(
              headline1: GoogleFonts.bellota(
                  textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ))),
          primaryColor: Colors.white),
    );
  }
}
