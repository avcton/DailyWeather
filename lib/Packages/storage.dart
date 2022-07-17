import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataStorage {
  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/dailyWeather.dat');
  }

  Future<String> readFile() async {
    try {
      final file = await _file;

      // Read the contents
      final content = await file.readAsString();

      return content;
    } catch (e) {
      return 'null';
    }
  }

  Future<File> writeFile(String timeOfDay) async {
    final file = await _file;

    //write the file
    return file.writeAsString(timeOfDay);
  }
}
