import 'package:daily_weather/Packages/generate_weather.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class Extended_Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Extended_Weather();
}

class _Extended_Weather extends State<Extended_Weather>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Weather>> weatherList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    weatherList = fetchFiveDayWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 23, 23, 1),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text("5 Day Consective",
                  style: GoogleFonts.bellota(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                  ))),
            ),
            Text("Hourly Forecasts",
                style: GoogleFonts.bellota(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ))),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<List<Weather>>(
                future: weatherList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        height: (size.height - size.height * 30 / 100),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {},
                                  leading: FadeInImage.assetNetwork(
                                      placeholder: 'assets/weather.png',
                                      image:
                                          'http://openweathermap.org/img/wn/${snapshot.data?[index].weatherIcon}@2x.png'),
                                  trailing: Text(
                                      "${weekDayToString(day: snapshot.data?[index].date?.weekday)} ${DateFormat('h:mm a').format(snapshot.data?[index].date ?? DateTime.now())}",
                                      style: GoogleFonts.bellota(
                                          textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ))),
                                  title: Text(
                                      "${snapshot.data?[index].weatherDescription}",
                                      style: GoogleFonts.bellota(
                                          textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ))),
                                );
                              }),
                        ),
                      );
                    }
                  }
                  return const Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  String weekDayToString({required var day}) {
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
    }
    return "null";
  }
}
