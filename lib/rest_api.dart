
import 'weather_model.dart';
import 'package:http/http.dart' as http;


Future<List<ListElement>> fetchDailyWeather() async {
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=duluth&units=imperial&cnt=8&appid=5aa6c40803fbb300fe98c6728bdafce7'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('fetchWeather - '+response.body);
    Weather weather = weatherFromJson(response.body);
    return weather.list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}