import 'dart:async';
import 'dart:typed_data';
import 'package:rxdart/subjects.dart';

import 'data.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class MemeTools {
  MemeData _data = MemeData();
  MemeData get data => _data;
  // StreamController<MemeData> _controller = StreamController<MemeData>();
  // Stream<MemeData> get stream => _controller.stream;
  // StreamSink<MemeData> get _sink => _controller.sink;
  BehaviorSubject<MemeData> _subject = BehaviorSubject<MemeData>();
  Stream<MemeData> get stream => _subject.stream;
  StreamSink<MemeData> get _sink => _subject.sink;

  MemeTools() {
    _sink.add(_data);
  }

  sinkMeme(MemeData meme, double deviceWidth) {
    _data = meme;
    _sink.add(_data);
  }

  void imageHeightOperation(MemeData memeData, double deviceWidth) {
    _data = memeData;
    List<Map<String, dynamic>> images = _data.images;
    double unexpandedImageHeight;
    double expandedImageHeight;
    images.forEach((element) {
      var imageHeight = img.decodeImage(element['data']).height;
      var imageWidth = img.decodeImage(element['data']).width;
      var aspectRatio = imageWidth / imageHeight;
      var res = deviceWidth / aspectRatio;
      if (expandedImageHeight == null || expandedImageHeight > res) {
        expandedImageHeight = res;
        unexpandedImageHeight = expandedImageHeight / 2;
      }
    });
    if (_data.expandedImageHeight == null ||
        expandedImageHeight < _data.expandedImageHeight) {
      _data.expandedImageHeight = expandedImageHeight;
      _data.unexpandedImageHeight = unexpandedImageHeight;
    }
    _sink.add(_data);
  }

  void dispose() {
    _subject.close();
  }
}

MemeTools memeTools = MemeTools();
