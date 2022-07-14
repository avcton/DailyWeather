import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:daily_weather/Screens/extended_weather.dart';
import 'package:daily_weather/Screens/weather_today.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherPage();
  }
}

class _WeatherPage extends State<WeatherPage> {
  int _currentIndex = 0;
  final _myscaffold = GlobalKey<ScaffoldState>();
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 1, minute: 30);
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
      key: _myscaffold,
      backgroundColor: const Color.fromRGBO(27, 23, 23, 1),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 23, 23, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                "Daily Weather",
                style: Theme.of(context).textTheme.headline1,
              )),
            )),
            const SizedBox(
              height: 120,
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: Text(
                "Daily Notification",
                style: Theme.of(context).textTheme.headline1,
              ),
              onTap: () {
                showTimePicker(context: context, initialTime: _timeOfDay)
                    .then((value) => setState(() {
                          _timeOfDay = value!;
                        }));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.feedback_rounded,
                color: Colors.white,
              ),
              title: Text(
                "Feedback",
                style: Theme.of(context).textTheme.headline1,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: const Color.fromRGBO(27, 23, 23, 1),
                        title: Center(
                          child: Text(
                            'Feedback Contact',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        content: SizedBox(
                          height: 100,
                          child: Center(
                              child: Text(
                            "avcton@gmail.com",
                            style: Theme.of(context).textTheme.headline1,
                          )),
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          WeatherToday(_myscaffold),
          Extended_Weather(),
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
