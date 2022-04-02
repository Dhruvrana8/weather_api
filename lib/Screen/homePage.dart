import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import "package:http/http.dart" as http;
import 'package:weather_api/models/currentCityName.dart';
import 'package:weather_api/models/currentDate.dart';
import 'package:weather_api/models/currentTemprature.dart';
import 'package:weather_api/models/line.dart';
import 'package:weather_api/models/minMaxTemp.dart';
import 'package:weather_api/models/weatherDetails.dart';
import 'package:weather_api/models/weathermodel.dart';

class HomeScreen extends StatefulWidget {
  final double longitude;
  final double latitude;
  const HomeScreen({Key? key, required this.longitude, required this.latitude})
      : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late WeatherApi weather;
  bool isReady = false;
  @override
  void initState() {
    super.initState();
    getData(widget.latitude, widget.longitude);
  }

  Future<void> getData(var lat, var lon) async {
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=4c521060ed841ef96b560845b3bdc78b");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      final parsedJson = convert.jsonDecode(data);
      setState(() {
        weather = WeatherApi.fromJson(parsedJson);
        isReady = true;
      });
      // var Temprature = convert.jsonDecode(data)["main"]["temp"];
      var cityName = convert.jsonDecode(data)["name"];
      // print(cityName);
    } else {
      // print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isReady
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CurrentCityName(cityName: weather.name),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              CurrentTemp(temp: weather.main.temp),
              SizedBox(height: MediaQuery.of(context).size.height * 0.001),
              WeatherDetails(
                  icon: weather.weather[0].icon, main: weather.weather[0].main),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const CurrentDate(),
              const Line(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MinMaxFeelsLikeTemp(
                        name: "Min Temp", value: weather.main.tempMin),
                    MinMaxFeelsLikeTemp(
                        name: "Feels Like", value: weather.main.feelsLike),
                    MinMaxFeelsLikeTemp(
                        name: "Max Temp", value: weather.main.tempMax),
                  ],
                ),
              ),
            ],
          );
  }
}
