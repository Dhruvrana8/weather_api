import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  final String icon;
  final String main;
  const WeatherDetails({Key? key, required this.icon, required this.main})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "images/png/weather_icons/$icon@2x.png",
          height: MediaQuery.of(context).size.height * 0.1,
          color: Colors.white,
        ),
        Text(main, style: const TextStyle(fontSize: 40, color: Colors.white))
      ],
    );
  }
}
