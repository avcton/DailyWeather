import 'package:daily_weather/Packages/get_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

WeatherFactory wf = WeatherFactory('528044a83bdd2bf9ca4268c210e01df7');

Future<Weather> fetchWeather() async {
  try {
    Position P = await determinePosition();
    Weather w = await wf.currentWeatherByLocation(P.latitude, P.longitude);
    return w;
  } catch (e) {
    return Future.error('$e');
  }
}

Future<List<Weather>> fetchFiveDayWeather() async {
  try {
    Position P = await determinePosition();
    List<Weather> forecast =
        await wf.fiveDayForecastByLocation(P.latitude, P.longitude);
    return forecast;
  } catch (e) {
    return Future.error(e);
  }
}
