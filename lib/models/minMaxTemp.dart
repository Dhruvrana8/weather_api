import 'package:flutter/material.dart';

class MinMaxFeelsLikeTemp extends StatelessWidget {
  final String name;
  final double value;
  const MinMaxFeelsLikeTemp({Key? key, required this.name, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double convert = 273.15;
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Row(
          children: [
            Text(
              (value - convert).toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              "°C",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            )
          ],
        )
      ],
    );
  }
}
