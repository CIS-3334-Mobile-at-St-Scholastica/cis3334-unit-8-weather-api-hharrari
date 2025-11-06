import 'package:flutter/material.dart';
import 'package:flutter_weatherapi_f25/rest_api.dart';
import 'package:flutter_weatherapi_f25/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CIS 3334 Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<List<ListElement>> futureWeatherForcasts;
  @override
  void initState() {
    super.initState();
    // call fetchWeather
    print('in initState about to get weather...');
    futureWeatherForcasts = fetchDailyWeather();
  }



  Widget weatherTile (ListElement weather) {
    // print ("Inside weatherTile and setting up tile for positon ${position}");
    return ListTile(
      leading: weatherIcon(weather.weather[0].main),
      title: Text('Wind degrees will be ${weather.wind.deg.toString()}'),
      subtitle: Text(weather.weather[0].description),
    );
  }

  Image weatherIcon(String weatherDescription){
    print("Loading icon for $weatherDescription");
    if (weatherDescription == "Rain"){
      print("Using rain.png");
      return Image(image: AssetImage('graphics/rain.png'));
    }
    if (weatherDescription == "Clouds"){
      print("Using rain.png");
      return Image(image: AssetImage('graphics/cloud.png'));
    }
    print("Using rain.png");
    return Image(image: AssetImage('graphics/sun.png'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: futureWeatherForcasts,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null || asyncSnapshot.connectionState == ConnectionState.none){
            return Container();

          }
          List<ListElement> weather = asyncSnapshot.data!;
          return ListView.builder(
            itemCount: weather.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: weatherTile(weather[position]),
              );
            },
          );
        }
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}