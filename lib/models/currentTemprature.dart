import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentTemp extends StatelessWidget {
  final double temp;
  const CurrentTemp({Key? key, required this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double convert = 273.15;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Text(
            (temp - convert).toStringAsFixed(2),
            style: GoogleFonts.openSansCondensed(
              fontSize: 65,
              color: Colors.white,
            ),
          ),
          const Text("°C", style: TextStyle(fontSize: 70, color: Colors.white))
        ],
      ),
    );
  }
}
