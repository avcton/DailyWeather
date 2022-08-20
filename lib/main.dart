import 'package:daily_weather/Packages/notification_handler.dart';
import 'package:daily_weather/Packages/storage.dart';
import 'package:daily_weather/Screens/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/weather_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  NotificationHandler().initNotification();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  String data = await DataStorage().readFile();
  if (data.isEmpty || data == 'null') {
    DataStorage().writeFile('7:30');
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    listenNotifications();
    super.initState();
  }

  void listenNotifications() {
    NotificationHandler.onNotifications.stream.listen((String? payLoad) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Weather',
      home: WeatherAnimation(),
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
