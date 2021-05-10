// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:meme_creator_2/tools.dart';
import 'package:meme_creator_2/widgets.dart';

import 'data.dart';

class MemeCreator extends StatefulWidget {
  @override
  _MemeCreatorState createState() => _MemeCreatorState();
}

class _MemeCreatorState extends State<MemeCreator> {
  MemeTools memeTools = MemeTools();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamWidget<MemeData>(
          stream: memeTools.stream,
          widget: (context, meme) => Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                meme.title != ""
                    ? Padding(
                        padding: EdgeInsets.all(meme.padding),
                        child: Text(
                          meme.title,
                          style: meme.titleStyle,
                          textAlign: meme.titleAlign,
                          textDirection: meme.titleDirection,
                        ),
                      )
                    : Container(),
                Wrap(
                  children: List.generate(
                    meme.images.length,
                    (index) => Padding(
                      padding: EdgeInsets.all(meme.padding),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(meme.borderRadius),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onDoubleTap: () {
                            meme.images[index]['expanded'] =
                                !meme.images[index]['expanded'];
                            memeTools.sinkMeme(meme);
                          },
                          onLongPress: () {
                            meme.images.removeAt(index);
                            memeTools.sinkMeme(meme);
                          },
                          child: Stack(
                            children: [
                              InteractiveViewer(
                                maxScale: 3,
                                child: Image.memory(
                                  meme.images[index]['data'],
                                  width: meme.images[index]['expanded']
                                      ? MediaQuery.of(context).size.width -
                                          meme.padding * 2
                                      : MediaQuery.of(context).size.width * .5 -
                                          meme.padding * 2,
                                  height:
                                      MediaQuery.of(context).size.height * .25 -
                                          meme.padding * 2 * meme.images.length,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                width: meme.images[index]['expanded']
                                    ? MediaQuery.of(context).size.width -
                                        meme.padding * 2
                                    : MediaQuery.of(context).size.width * .5 -
                                        meme.padding * 2,
                                top: 5,
                                child: Text(
                                  meme.images[index]['topText'],
                                  style: meme.images[index]['topTextStyle'],
                                  textAlign: meme.images[index]
                                      ['topTextAlignment'],
                                  textDirection: meme.images[index]
                                      ['topTextDirection'],
                                ),
                              ),
                              Positioned(
                                width: meme.images[index]['expanded']
                                    ? MediaQuery.of(context).size.width -
                                        meme.padding * 2
                                    : MediaQuery.of(context).size.width * .5 -
                                        meme.padding * 2,
                                bottom: 5,
                                child: Text(
                                  meme.images[index]['bottomText'],
                                  style: meme.images[index]['bottomTextStyle'],
                                  textAlign: meme.images[index]
                                      ['bottomTextAlignment'],
                                  textDirection: meme.images[index]
                                      ['bottomTextDirection'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Tools"),
        icon: Icon(Icons.build),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return StreamWidget<MemeData>(
                stream: memeTools.stream,
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
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(5),
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text("Meme Title"),
                                leading: Icon(Icons.article_outlined),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(5),
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text("Add Pictures"),
                                leading: Icon(Icons.image),
                                onTap: () async {
                                  var fs = await MultiMediaPicker.pickImages();
                                  int i = 0;
                                  fs.forEach((element) {
                                    meme.images.add({
                                      'data': element.readAsBytesSync(),
                                      'index': i,
                                      'expanded': false,
                                      'topText': 'Top Meme text',
                                      'bottomText': 'Bottom Meme text',
                                      'topTextDirection': TextDirection.ltr,
                                      'bottomTextDirection': TextDirection.ltr,
                                      'topTextAlignment': TextAlign.center,
                                      'bottomTextAlignment': TextAlign.center,
                                      'topTextStyle': TextStyle(),
                                      'bottomTextStyle': TextStyle(),
                                    });
                                    i++;
                                  });
                                  memeTools.sinkMeme(meme);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          title: Text("Padding"),
                          leading: Icon(Icons.space_bar),
                          subtitle: Slider(
                            value: memeTools.data.padding,
                            divisions: 20,
                            label: memeTools.data.padding.toInt().toString(),
                            max: 20,
                            min: 0,
                            onChanged: (value) {
                              meme.padding = value;
                              memeTools.sinkMeme(meme);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          leading: Icon(Icons.dashboard_rounded),
                          title: Text("Border radius"),
                          subtitle: Slider(
                            value: meme.borderRadius,
                            min: 0,
                            max: 45,
                            divisions: 45,
                            label: meme.borderRadius.toInt().toString(),
                            onChanged: (value) {
                              meme.borderRadius = value;
                              memeTools.sinkMeme(meme);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
