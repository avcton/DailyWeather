import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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
  int _currentIndex = 0;
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 23, 23, 1),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Center(
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      child: Image(
                        image: AssetImage('assets/weather.png'),
                        fit: BoxFit.cover,
                      ),
                    )),
                Text("Daily Weather Report",
                    style: Theme.of(context).textTheme.headline1),
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
                                  errorBuilder: (context, error, stackTrace) {
                                return Text(
                                  "Error Loading Image...",
                                  style: Theme.of(context).textTheme.headline1,
                                );
                              }),
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
          Extended_Weather()
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.black,
          showElevation: true,
          selectedIndex: _currentIndex,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          items: [
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                activeColor: Colors.grey,
                icon: const Icon(
                  Icons.cloud_sync_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Weather',
                  style: TextStyle(color: Colors.white),
                )),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                activeColor: Colors.grey,
                icon: const Icon(
                  Icons.line_style,
                  color: Colors.white,
                ),
                title: const Text('Details',
                    style: TextStyle(color: Colors.white)))
          ],
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          }),
    );
  }
}
