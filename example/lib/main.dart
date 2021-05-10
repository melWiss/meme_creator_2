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
          )),
      home: MemeCreator(),
    );
  }
}
