import 'package:flutter/material.dart';
import 'package:weather_app/page/home_page.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: bgColor,
        textTheme: TextTheme(
          //For Headline
          headlineLarge: TextStyle(
            fontFamily: "Omsk",
            fontSize: 24,
            color: white,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Omsk",
            fontSize: 24,
            color: white,
          ),
          headlineSmall: TextStyle(
            fontFamily: "Omsk",
            fontSize: 24,
            color: white,
          ),

          //For Body
          bodyLarge: TextStyle(
            fontFamily: "Omsk",
            fontSize: 16,
            color: greyTransparent,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Omsk",
            fontSize: 16,
            color: greyTransparent,
          ),
          bodySmall: TextStyle(
            fontFamily: "Omsk",
            fontSize: 16,
            color: greyTransparent,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
