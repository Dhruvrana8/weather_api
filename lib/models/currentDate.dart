import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Center(
      child: Text(
        formattedDate,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
