import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meme_creator_2/meme_creator_2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purple,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.purple),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.purple,
          inactiveTrackColor: Colors.black12,
          thumbColor: Colors.deepPurple,
          overlayColor: Color(0x33673AB7),
          valueIndicatorColor: Colors.purpleAccent,
          inactiveTickMarkColor: Colors.transparent,
          activeTickMarkColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.purple,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.purple,
          ),
        ),
        indicatorColor: Colors.purple,
      ),
      home: MemeCreator(),
    );
  }
}
