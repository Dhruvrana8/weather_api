import 'package:flutter/material.dart';

class CurrentCityName extends StatelessWidget {
  final String cityName;
  const CurrentCityName({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName,
      style: const TextStyle(
        fontSize: 65,
        color: Colors.white,
      ),
    );
  }
}
