import 'package:daily_weather/Screens/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class WeatherAnimation extends StatefulWidget {
  WeatherAnimation({Key? key}) : super(key: key);

  @override
  State<WeatherAnimation> createState() => _WeatherAnimation();
}

class _WeatherAnimation extends State<WeatherAnimation> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = OneShotAnimation('Burst', onStop: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WeatherPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(27, 23, 23, 1),
      child:
          RiveAnimation.asset('assets/weather.riv', controllers: [_controller]),
    );
  }
}
