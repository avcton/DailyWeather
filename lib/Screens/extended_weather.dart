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
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  weatherList = fetchFiveDayWeather();
                });
              },
              child: FutureBuilder<List<Weather>>(
                  future: weatherList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Container(
                            color: Colors.black,
                            child: Text(snapshot.error.toString(),
                                style: Theme.of(context).textTheme.headline1));
                      } else if (snapshot.hasData) {
                        final sortedList = sortWeatherDays(snapshot.data ?? []);

                        return Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SizedBox(
                            height: size.height - size.height * 40 / 100,
                            child: ListView.separated(
                                separatorBuilder: ((context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                }),
                                scrollDirection: Axis.horizontal,
                                itemCount: sortedList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: size.width - size.width * 8 / 100,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 25.0),
                                        child: Column(children: [
                                          Center(
                                            child: Text(
                                                weekDayToString(
                                                    day: sortedList[index][0]
                                                        .date!
                                                        .weekday),
                                                style: GoogleFonts.bellota(
                                                    fontSize: size.width -
                                                        size.width * 90 / 100,
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ))),
                                          ),
                                          const SizedBox(height: 20),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount:
                                                    sortedList[index].length,
                                                itemBuilder: (context, indx) {
                                                  return ListTile(
                                                    onTap: () {},
                                                    leading: Image.asset(
                                                      'assets/WeatherCodes/${sortedList[index][indx].weatherIcon}@2x.png',
                                                    ),
                                                    trailing: Text(
                                                        DateFormat('h:mm a')
                                                            .format(sortedList[
                                                                            index]
                                                                        [indx]
                                                                    .date ??
                                                                DateTime.now()),
                                                        style:
                                                            GoogleFonts.bellota(
                                                                textStyle:
                                                                    TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ))),
                                                    title: Text(
                                                        "${sortedList[index][indx].weatherDescription}",
                                                        style:
                                                            GoogleFonts.bellota(
                                                                textStyle:
                                                                    TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ))),
                                                  );
                                                }),
                                          ),
                                        ]),
                                      ));
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
                  }),
            )
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

  List<List<Weather>> sortWeatherDays(List<Weather> list) {
    int currentDay = list[0].date!.weekday;

    List<List<Weather>> sortedList = [];
    List<Weather> Monday = [];
    List<Weather> Tuesday = [];
    List<Weather> Wednesday = [];
    List<Weather> Thursday = [];
    List<Weather> Friday = [];
    List<Weather> Saturday = [];
    List<Weather> Sunday = [];

    Map<int, List<Weather>> dayMap = {
      1: Monday,
      2: Tuesday,
      3: Wednesday,
      4: Thursday,
      5: Friday,
      6: Saturday,
      7: Sunday,
    };

    for (var weather in list) {
      if (weather.date!.weekday == 1) {
        Monday.add(weather);
      }
      if (weather.date!.weekday == 2) {
        Tuesday.add(weather);
      }
      if (weather.date!.weekday == 3) {
        Wednesday.add(weather);
      }
      if (weather.date!.weekday == 4) {
        Thursday.add(weather);
      }
      if (weather.date!.weekday == 5) {
        Friday.add(weather);
      }
      if (weather.date!.weekday == 6) {
        Saturday.add(weather);
      }
      if (weather.date!.weekday == 7) {
        Sunday.add(weather);
      }
    }

    for (int i = 0; i < 7; i++, currentDay++) {
      if (currentDay > 7) {
        currentDay = 1;
      }
      if (dayMap[currentDay]!.isNotEmpty) {
        sortedList.add(dayMap[currentDay] ?? []);
      }
    }

    return sortedList;
  }
}
