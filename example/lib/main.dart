import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meme_creator_2/meme_creator_2.dart';
import 'package:meme_creator_2/tools.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MemeTools memeController = MemeTools();
  ScreenshotController screenshotController = ScreenshotController();

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
      home: MemeScreen(),
    );
  }
}

class MemeScreen extends StatefulWidget {
  const MemeScreen({Key? key}) : super(key: key);

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  MemeTools memeController = MemeTools();
  ScreenshotController screenshotController = ScreenshotController();
  bool saveLoading = false;
  bool shareLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MemeCreator(
        memeController: memeController,
        screenshotController: screenshotController,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: FloatingActionButton(
              child: saveLoading
                  ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        Text("Save"),
                      ],
                    ),
              onPressed: () async {
                if (!saveLoading) {
                  if (!(memeController.data.title.isEmpty &&
                      memeController.data.images.isEmpty)) {
                    setState(() {
                      saveLoading = true;
                    });
                    var f = await (screenshotController.capture());
                    Future.value(ImageGallerySaver.saveImage(f!,
                            name:
                                "MemeCreator2-${DateTime.now().millisecondsSinceEpoch}.png"))
                        .then((value) {
                      if (value['isSuccess']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Meme saved Successfully!"),
                            action: SnackBarAction(
                              label: "Share",
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                WcFlutterShare.share(
                                  sharePopupTitle: "Share",
                                  mimeType: "image/png",
                                  text: memeController.data.title,
                                  subject: memeController.data.title,
                                  bytesOfFile: f,
                                  fileName: "meme.png",
                                );
                              },
                            ),
                          ),
                        );
                      }
                      setState(() {
                        saveLoading = false;
                      });
                    }).catchError((onError) {
                      debugPrint(onError.toString());
                      setState(() {
                        saveLoading = false;
                      });
                    });
                  }
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: FloatingActionButton(
              child: shareLoading
                  ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share),
                        Text("Share"),
                      ],
                    ),
              onPressed: () async {
                if (!shareLoading) {
                  if (!(memeController.data.title.isEmpty &&
                      memeController.data.images.isEmpty)) {
                    setState(() {
                      shareLoading = true;
                    });
                    var f = await (screenshotController.capture());
                    Future.value(ImageGallerySaver.saveImage(f!,
                            name:
                                "MemeCreator2-${DateTime.now().millisecondsSinceEpoch}.png"))
                        .then((value) {
                      if (value['isSuccess']) {
                        WcFlutterShare.share(
                          sharePopupTitle: "Share",
                          mimeType: "image/png",
                          text: memeController.data.title,
                          subject: memeController.data.title,
                          bytesOfFile: f,
                          fileName: "meme.png",
                        );
                      }
                      setState(() {
                        shareLoading = false;
                      });
                    }).catchError((onError) {
                      debugPrint(onError);
                      setState(() {
                        shareLoading = false;
                      });
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
