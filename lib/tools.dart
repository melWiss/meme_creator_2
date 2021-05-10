import 'dart:async';
import 'dart:typed_data';
import 'package:rxdart/subjects.dart';

import 'data.dart';
import 'package:flutter/material.dart';

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

  sinkMeme(MemeData meme) {
    _data = meme;
    _sink.add(_data);
  }

  void dispose() {
    _subject.close();
  }
}
