import 'package:daily_weather/Packages/generate_weather.dart';
import 'package:daily_weather/Screens/extended_weather.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherPage();
  }
}

class _WeatherPage extends State<WeatherPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Scaffold(
          backgroundColor: const Color.fromRGBO(27, 23, 23, 1),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Text("Welcome",
                      style: GoogleFonts.indieFlower(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 0))),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text("To",
                    style: GoogleFonts.indieFlower(
                        textStyle: TextStyle(
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ))),
                const SizedBox(
                  height: 10,
                ),
                Text("Daily Weather Report",
                    style: GoogleFonts.bellota(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ))),
                const Divider(
                    height: 50,
                    thickness: 5,
                    indent: 80,
                    endIndent: 80,
                    color: Colors.white),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text("Today's report",
                      style: GoogleFonts.bellota(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                      ))),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<Weather>(
                    future: fetchWeather(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('$snapshot.error');
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data?.weatherIcon}@4x.png',
                              ),
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    Text(
                                        '${snapshot.data?.areaName} [${snapshot.data?.country}]',
                                        style: GoogleFonts.bellota(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                    Text('${snapshot.data?.temperature}',
                                        style: GoogleFonts.bellota(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                    Text(
                                        'Cloudiness: ${snapshot.data?.cloudiness}',
                                        style: GoogleFonts.bellota(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('${snapshot.data?.weatherDescription}',
                                        style: GoogleFonts.bellota(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("made by avcton",
                          style: GoogleFonts.indieFlower(
                              textStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Extended_Weather(),
      ],
    );
  }
}
