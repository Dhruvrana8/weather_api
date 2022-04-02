import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import "package:http/http.dart" as http;
import 'package:weather_api/models/weathermodel.dart';
import 'package:intl/intl.dart';

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
  // DateTime now = DateTime.now();
  // String formattedTime = DateFormat('kk:mm:ss').format(now);
  // String formattedDate = DateFormat('EEE d MMM').format(now);
  // late final WeatherApi weather;
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
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isReady
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                weather.name,
                style: const TextStyle(
                  fontSize: 65,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      (weather.main.temp - 273.15).toStringAsFixed(2),
                      style: GoogleFonts.openSansCondensed(
                        fontSize: 65,
                        color: Colors.white,
                      ),
                    ),
                    const Text("°C",
                        style: TextStyle(fontSize: 70, color: Colors.white))
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.001),
              Row(
                children: [
                  Container(
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Image.asset(
                      "images/png/weather_icons/${weather.weather[0].icon}@2x.png",
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                    ),
                  ),
                  Text(weather.weather[0].main,
                      style: const TextStyle(fontSize: 40, color: Colors.white))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Center(
                child: Text(
                  "Jan 29 2022",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 1,
                  color: Colors.white30),
            ],
          );
  }
}
