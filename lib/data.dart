import 'dart:typed_data';

import 'package:flutter/material.dart';

class MemeData {
  String title = "Meme title";
  List<Map<String, dynamic>> images = [];
  double padding = 5;
  double borderRadius = 0;
  double shadowWidth = 0;
  Color shadowColor = Colors.black;
  TextAlign titleAlign = TextAlign.center;
  TextDirection titleDirection = TextDirection.ltr;
  TextStyle titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}
