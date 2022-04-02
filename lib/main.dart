import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_api/Screen/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_api/models/backgroundImage.dart';

import 'models/weathermodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get http => null;

  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  String currentAddress = '';

  Position? currentposition;
  late double latitude;
  late double longitude;

  Future<void> _determinePosition() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              "Weather app",
              style: GoogleFonts.openSansCondensed(
                // fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: const Icon(
              Icons.search,
              size: 30,
            ),
            actions: const [
              Icon(
                Icons.menu,
                size: 30,
              )
            ],
          ),
          body: Stack(
            children: [
              // SvgPicture.asset("assets/images/5.svg", fit: BoxFit.cover),
              // SvgPicture.asset("images/svg/images/6.svg", fit: BoxFit.cover),
              const BackGroundImage(),
              Container(
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              Builder(builder: (context) {
                final condition = currentAddress == "";
                return condition
                    ? const Center(
                        child: Text("Loading",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HomeScreen(
                            longitude: longitude, latitude: latitude),
                      );
              }),
            ],
          ),
        ));
  }
}
