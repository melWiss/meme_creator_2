// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
export 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_save/image_save.dart';
// export 'package:image_save/image_save.dart';
import 'package:meme_creator_2/scale_navig.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:meme_creator_2/tools.dart';
import 'package:meme_creator_2/widgets.dart';
import 'package:screenshot/screenshot.dart';
export 'package:screenshot/screenshot.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
export 'package:wc_flutter_share/wc_flutter_share.dart';

import 'api_image_picker.dart';
import 'data.dart';
import 'slide_navig.dart';

class MemeCreator extends StatefulWidget {
  final MemeTools memeController;
  final ScreenshotController screenshotController;
  MemeCreator({
    required this.memeController,
    required this.screenshotController,
  });
  @override
  _MemeCreatorState createState() => _MemeCreatorState();
}

class _MemeCreatorState extends State<MemeCreator> {
  bool saveLoading = false;
  bool shareLoading = false;
  GlobalKey canvasKey = GlobalKey();
  GlobalKey pickImageKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  MemeTools? memeTools;
  ScreenshotController? screenshotController;

  @override
  void initState() {
    super.initState();
    memeTools = widget.memeController;
    screenshotController = widget.screenshotController;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future:
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      builder: (context, snap) => Scaffold(
        body: Center(
          child: UiWidget(
            scrollController: scrollController,
            screenshotController: screenshotController,
            canvasKey: canvasKey,
            memeTools: memeTools,
          ),
        ),
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              tooltip: "Tools",
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.build),
                  Text("Tools"),
                ],
              ),
              onPressed: () {
                bottomSheet(
                  context,
                  (context) {
                    return StreamWidget<MemeData>(
                      stream: memeTools!.stream,
                      widget: (context, meme) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Tools",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Divider(
                            indent: MediaQuery.of(context).size.width * .2,
                            endIndent: MediaQuery.of(context).size.width * .2,
                            color: Colors.black,
                            thickness: 3,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: listTileMaterial(
                                          ListTile(
                                            title: Text("Meme Title"),
                                            subtitle: Text(
                                                "A text that is shown at the top."),
                                            leading:
                                                Icon(Icons.article_outlined),
                                            onTap: () {
                                              bottomSheet(
                                                context,
                                                (context) => memeTitleSheet(
                                                    meme!, memeTools!),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: listTileMaterial(
                                          ListTile(
                                            title: Text("Add Pictures"),
                                            subtitle: Text(
                                                "Add pictures from Device."),
                                            leading: Icon(Icons.image),
                                            onTap: () => addImagesFromDevice(
                                                meme!,
                                                screenSize.width,
                                                memeTools!),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: listTileMaterial(
                                          ListTile(
                                            title: Text("Floating Text"),
                                            subtitle: Text(
                                                "A text that you can drag and drop."),
                                            leading: Icon(Icons.article),
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    floatingTextAlert(
                                                  canvasKey,
                                                  meme!,
                                                  context,
                                                  memeTools,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: listTileMaterial(
                                          ListTile(
                                            key: pickImageKey,
                                            title: Text("Pick Image"),
                                            subtitle: Text(
                                                "Pick images from the Internet"),
                                            leading:
                                                Icon(Icons.add_photo_alternate),
                                            onTap: () {
                                              var size =
                                                  MediaQuery.of(context).size;
                                              var obj = pickImageKey
                                                      .currentContext!
                                                      .findRenderObject()
                                                  as RenderBox;
                                              var position = obj.localToGlobal(
                                                Offset.zero,
                                              );
                                              debugPrint(position.toString());
                                              debugPrint(size.toString());
                                              debugPrint(obj.size.toString());
                                              Navigator.of(context).push(
                                                SlideNavigation(
                                                  child: ApiImagePicker(
                                                    memeController: memeTools,
                                                  ),
                                                  // borderRadius: 40,
                                                  curve: Curves.elasticOut,
                                                  reverseCurve:
                                                      Curves.easeInExpo,
                                                  alignment: Alignment(
                                                    position.dx / size.width,
                                                    (position.dy -
                                                            obj.size.height *
                                                                3.3) /
                                                        size.height,
                                                  ),
                                                  animationDuration: 650,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      title: Text("Padding"),
                                      leading: Icon(Icons.space_bar),
                                      subtitle: Slider(
                                        value: memeTools!.data.containerPadding,
                                        divisions: 20,
                                        label: memeTools!.data.containerPadding
                                            .toInt()
                                            .toString(),
                                        max: 20,
                                        min: 0,
                                        onChanged: (value) {
                                          meme!.containerPadding = value;
                                          memeTools!
                                              .sinkMeme(meme, screenSize.width);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      title: Text("Images Padding"),
                                      leading: Icon(Icons.image_aspect_ratio),
                                      subtitle: Slider(
                                        value: memeTools!.data.imagesPadding,
                                        divisions: 20,
                                        label: memeTools!.data.imagesPadding
                                            .toInt()
                                            .toString(),
                                        max: 20,
                                        min: 0,
                                        onChanged: (value) {
                                          meme!.imagesPadding = value;
                                          memeTools!
                                              .sinkMeme(meme, screenSize.width);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      leading: Icon(Icons.dashboard_rounded),
                                      title: Text("Border radius"),
                                      subtitle: Slider(
                                        value: meme!.borderRadius,
                                        min: 0,
                                        max: 45,
                                        divisions: 45,
                                        label: meme.borderRadius
                                            .toInt()
                                            .toString(),
                                        onChanged: (value) {
                                          meme.borderRadius = value;
                                          memeTools!
                                              .sinkMeme(meme, screenSize.width);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      leading: Icon(Icons.height),
                                      title: Text("Image Height"),
                                      subtitle: Slider(
                                        value: meme.imageHeight,
                                        min: 25,
                                        max: 100,
                                        divisions: 75,
                                        label:
                                            meme.imageHeight.toInt().toString(),
                                        onChanged: (value) {
                                          meme.imageHeight = value;
                                          memeTools!
                                              .sinkMeme(meme, screenSize.width);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      leading: Icon(Icons.palette),
                                      title: Text("Background Color"),
                                      trailing: Container(
                                        height: 20,
                                        width: 30,
                                        color: meme.memeBackgroundColor,
                                      ),
                                      onTap: () async {
                                        meme.memeBackgroundColor =
                                            await showColorPickerDialog(
                                          context,
                                          meme.memeBackgroundColor,
                                        );
                                        memeTools!
                                            .sinkMeme(meme, screenSize.width);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            /*Padding(
              padding: EdgeInsets.only(left: 5),
              child: FloatingActionButton(
                child: saveLoading
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
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
                    if (!(memeTools.data.title.isEmpty &&
                        memeTools.data.images.isEmpty)) {
                      setState(() {
                        saveLoading = true;
                      });
                      var f = await screenshotController.capture();
                      ImageSave.saveImage(f,
                              "MemeCreator2-${DateTime.now().millisecondsSinceEpoch}.jpeg")
                          .then((value) {
                        if (value) {
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
                                    text: memeTools.data.title,
                                    subject: memeTools.data.title,
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
                        debugPrint(onError);
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
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
                    if (!(memeTools.data.title.isEmpty &&
                        memeTools.data.images.isEmpty)) {
                      setState(() {
                        shareLoading = true;
                      });
                      var f = await screenshotController.capture();
                      ImageSave.saveImage(f,
                              "MemeCreator2-${DateTime.now().millisecondsSinceEpoch}.jpeg")
                          .then((value) {
                        if (value) {
                          WcFlutterShare.share(
                            sharePopupTitle: "Share",
                            mimeType: "image/png",
                            text: memeTools.data.title,
                            subject: memeTools.data.title,
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
            ),*/
          ],
        ),
      ),
    );
  }
}
