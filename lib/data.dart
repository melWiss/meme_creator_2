import 'dart:typed_data';

import 'package:flutter/material.dart';

class MemeData {
  String title = "";
  List<Map<String, dynamic>> images = [];
  double containerPadding = 5;
  double titlePadding = 5;
  double imagesPadding = 5;
  double borderRadius = 0;
  double shadowWidth = 0;
  double imageHeight = 25;
  Color shadowColor = Colors.black;
  TextAlign titleAlign = TextAlign.center;
  TextDirection titleDirection = TextDirection.ltr;
  TextStyle titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// var captionsStyle = {
//   'data': element.readAsBytesSync(),
//   'index': i,
//   'expanded': false,
//   'topText': 'Top Meme text',
//   'bottomText': 'Bottom Meme text',
//   'topTextDirection': TextDirection.ltr,
//   'bottomTextDirection': TextDirection.ltr,
//   'topTextAlignment': TextAlign.center,
//   'bottomTextAlignment': TextAlign.center,
//   'topTextStyle': TextStyle(
//     fontSize: 18,
//     color: Colors.white,
//     shadows: [
//       Shadow(
//         offset: Offset(1.12, 1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(1.12, -1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(-1.12, 1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(-1.12, -1.12),
//         color: Colors.black,
//       ),
//     ],
//   ),
//   'bottomTextStyle': TextStyle(
//     fontSize: 18,
//     color: Colors.white,
//     shadows: [
//       Shadow(
//         offset: Offset(1.12, 1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(1.12, -1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(-1.12, 1.12),
//         color: Colors.black,
//       ),
//       Shadow(
//         offset: Offset(-1.12, -1.12),
//         color: Colors.black,
//       ),
//     ],
//   ),
// };
