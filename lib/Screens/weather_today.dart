import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import '../Packages/generate_weather.dart';

class WeatherToday extends StatefulWidget {
  final myscaffold;

  WeatherToday(this.myscaffold, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeatherToday();
  }
}

class _WeatherToday extends State<WeatherToday>
    with AutomaticKeepAliveClientMixin {
  late Future<Weather> weather;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    weather = fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size.height;
    return Stack(children: [
      Positioned(
          left: 20,
          top: 40,
          child: IconButton(
            icon: Icon(
              color: Colors.white,
              Icons.menu,
              size: 35,
            ),
            onPressed: () {
              widget.myscaffold.currentState!.openDrawer();
            },
          )),
      Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  height: 100,
                  child: SvgPicture.asset(
                    'assets/weather.svg',
                    color: Colors.white,
                    placeholderBuilder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(30),
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      );
                    },
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Today's report",
                  style: GoogleFonts.bellota(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Theme.of(context).primaryColor,
                  ))),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<Weather>(
                future: weather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('$snapshot.error');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: size - size * 75 / 100,
                            child: Image.network(
                              'http://openweathermap.org/img/wn/${snapshot.data?.weatherIcon}@4x.png',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Text(
                                  "Error Loading Image...",
                                  style: Theme.of(context).textTheme.headline1,
                                );
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(20.0),
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
                                Text('Cloudiness: ${snapshot.data?.cloudiness}',
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
    ]);
  }
}
