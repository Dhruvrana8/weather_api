import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BackGroundImage extends StatefulWidget {
  const BackGroundImage({Key? key}) : super(key: key);

  @override
  State<BackGroundImage> createState() => _BackGroundImageState();
}

class _BackGroundImageState extends State<BackGroundImage> {
  @override
  Widget build(BuildContext context) {
    var time = int.parse(DateFormat("KK").format(DateTime.now()).toString());
    var AMPM = DateFormat("a").format(DateTime.now()).toString();
    return AMPM == "AM"
        ? time > 00 && time < 3
            ? SvgPicture.asset(
                "images/svg/images/6.svg",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
            : time > 3 && time < 6
                ? SvgPicture.asset(
                    "images/svg/images/7.svg",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  )
                : time > 6 && time < 9
                    ? SvgPicture.asset(
                        "images/svg/images/8.svg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
                    : SvgPicture.asset(
                        "images/svg/images/1.svg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
        : time > 0 && time <= 3
            ? SvgPicture.asset(
                "images/svg/images/2.svg",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
            : time > 3 && time <= 6
                ? SvgPicture.asset(
                    "images/svg/images/3.svg",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  )
                : time > 6 && time <= 9
                    ? SvgPicture.asset(
                        "images/svg/images/4.svg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
                    : SvgPicture.asset(
                        "images/svg/images/5.svg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      );
  }
}
