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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
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
    print(MediaQuery.of(context).size);
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
