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
                        padding: EdgeInsets.all(meme.titlePadding),
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
                          onTap: () {
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
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController caption1 =
                                    TextEditingController(
                                        text: meme.images[index]['topText']);
                                TextEditingController caption2 =
                                    TextEditingController(
                                        text: meme.images[index]['bottomText']);
                                return StreamWidget<MemeData>(
                                  stream: memeTools.stream,
                                  widget: (context, meme) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Edit Captions",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      Divider(
                                        indent:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        endIndent:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        color: Colors.black,
                                        thickness: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: caption1,
                                          decoration: InputDecoration(
                                            hintText: "Caption #1",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            meme.images[index]['topText'] =
                                                value;
                                            memeTools.sinkMeme(meme);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: caption2,
                                          decoration: InputDecoration(
                                            hintText: "Caption #2",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            meme.images[index]['bottomText'] =
                                                value;
                                            memeTools.sinkMeme(meme);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text('Caption Size'),
                                            leading: Icon(Icons.text_fields),
                                            subtitle: Slider(
                                              value: (meme.images[index]
                                                          ['topTextStyle']
                                                      as TextStyle)
                                                  .fontSize,
                                              max: 50,
                                              min: 10,
                                              divisions: 40,
                                              label: (meme.images[index]
                                                          ['topTextStyle']
                                                      as TextStyle)
                                                  .fontSize
                                                  .toInt()
                                                  .toString(),
                                              onChanged: (double value) {
                                                meme.images[index]
                                                    ['topTextStyle'] = (meme
                                                                .images[index]
                                                            ['topTextStyle']
                                                        as TextStyle)
                                                    .copyWith(fontSize: value);
                                                meme.images[index]
                                                    ['bottomTextStyle'] = (meme
                                                                .images[index]
                                                            ['bottomTextStyle']
                                                        as TextStyle)
                                                    .copyWith(fontSize: value);
                                                memeTools.sinkMeme(meme);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 4,
                                          child: SwitchListTile(
                                            title: Text('Bold?'),
                                            secondary: Icon(
                                                Icons.font_download_outlined),
                                            value: (meme.images[index]
                                                            ['topTextStyle']
                                                        as TextStyle)
                                                    .fontWeight ==
                                                FontWeight.bold,
                                            onChanged: (value) {
                                              meme.images[index]
                                                  ['topTextStyle'] = (meme
                                                              .images[index]
                                                          ['topTextStyle']
                                                      as TextStyle)
                                                  .copyWith(
                                                      fontWeight: value
                                                          ? FontWeight.bold
                                                          : FontWeight.normal);
                                              meme.images[index]
                                                  ['bottomTextStyle'] = (meme
                                                              .images[index]
                                                          ['bottomTextStyle']
                                                      as TextStyle)
                                                  .copyWith(
                                                      fontWeight: value
                                                          ? FontWeight.bold
                                                          : FontWeight.normal);
                                              memeTools.sinkMeme(meme);
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text('Caption Direction'),
                                            leading: Icon(Icons.directions),
                                            subtitle: Row(
                                              children: [
                                                Text("Left to Right"),
                                                Radio<TextDirection>(
                                                  groupValue: meme.images[index]
                                                      ['topTextDirection'],
                                                  value: TextDirection.ltr,
                                                  onChanged: (value) {
                                                    meme.images[index][
                                                            'topTextDirection'] =
                                                        value;
                                                    meme.images[index][
                                                            'bottomTextDirection'] =
                                                        value;
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                                Text("Right to Left"),
                                                Radio<TextDirection>(
                                                  groupValue: meme.images[index]
                                                      ['topTextDirection'],
                                                  value: TextDirection.rtl,
                                                  onChanged: (value) {
                                                    meme.images[index][
                                                            'topTextDirection'] =
                                                        value;
                                                    meme.images[index][
                                                            'bottomTextDirection'] =
                                                        value;
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text('Text Alignment'),
                                            leading:
                                                Icon(Icons.format_align_center),
                                            subtitle: Row(
                                              children: [
                                                Text("Start"),
                                                Radio<TextAlign>(
                                                  groupValue: meme.images[index]
                                                      ['topTextAlignment'],
                                                  value: TextAlign.start,
                                                  onChanged: (value) {
                                                    meme.images[index][
                                                            'topTextAlignment'] =
                                                        value;
                                                    meme.images[index][
                                                            'bottomTextAlignment'] =
                                                        value;
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                                Text("Center"),
                                                Radio<TextAlign>(
                                                  groupValue: meme.images[index]
                                                      ['topTextAlignment'],
                                                  value: TextAlign.center,
                                                  onChanged: (value) {
                                                    meme.images[index][
                                                            'topTextAlignment'] =
                                                        value;
                                                    meme.images[index][
                                                            'bottomTextAlignment'] =
                                                        value;
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                                Text("End"),
                                                Radio<TextAlign>(
                                                  groupValue: meme.images[index]
                                                      ['topTextAlignment'],
                                                  value: TextAlign.end,
                                                  onChanged: (value) {
                                                    meme.images[index][
                                                            'topTextAlignment'] =
                                                        value;
                                                    meme.images[index][
                                                            'bottomTextAlignment'] =
                                                        value;
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text('Title Color'),
                                            leading: Icon(Icons.color_lens),
                                            trailing: Container(
                                              height: 20,
                                              width: 30,
                                              color: meme
                                                  .images[index]['topTextStyle']
                                                  .color,
                                            ),
                                            onTap: () async {
                                              var color =
                                                  await showColorPickerDialog(
                                                      context,
                                                      meme.titleStyle.color);
                                              meme.images[index]
                                                      ['topTextStyle'] =
                                                  (meme.images[index]
                                                              ['topTextStyle']
                                                          as TextStyle)
                                                      .copyWith(color: color);
                                              meme.images[index]
                                                  ['bottomTextStyle'] = (meme
                                                              .images[index]
                                                          ['bottomTextStyle']
                                                      as TextStyle)
                                                  .copyWith(color: color);
                                              memeTools.sinkMeme(meme);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              InteractiveViewer(
                                maxScale: 5,
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
            isScrollControlled: true,
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
                                onTap: () {
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
                                    isScrollControlled: true,
                                    builder: (context) {
                                      TextEditingController
                                          textEditingController =
                                          TextEditingController(
                                              text: meme.title);
                                      return StreamWidget<MemeData>(
                                        stream: memeTools.stream,
                                        widget: (context, meme) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Meme Title",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                            ),
                                            Divider(
                                              indent: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              endIndent: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              color: Colors.black,
                                              thickness: 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller:
                                                    textEditingController,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Write the meme title here",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  meme.title = value;
                                                  memeTools.sinkMeme(meme);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: ListTile(
                                                  title: Text('Title Size'),
                                                  leading:
                                                      Icon(Icons.text_fields),
                                                  subtitle: Slider(
                                                    value: meme
                                                        .titleStyle.fontSize,
                                                    max: 75,
                                                    min: 14,
                                                    divisions: 61,
                                                    label: meme
                                                        .titleStyle.fontSize
                                                        .toInt()
                                                        .toString(),
                                                    onChanged: (double value) {
                                                      meme.titleStyle = meme
                                                          .titleStyle
                                                          .copyWith(
                                                        fontSize: value,
                                                      );
                                                      memeTools.sinkMeme(meme);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: ListTile(
                                                  title: Text('Title Padding'),
                                                  leading:
                                                      Icon(Icons.space_bar),
                                                  subtitle: Slider(
                                                    value: meme.titlePadding,
                                                    max: 40,
                                                    min: 0,
                                                    divisions: 40,
                                                    label: meme.titlePadding
                                                        .toInt()
                                                        .toString(),
                                                    onChanged: (double value) {
                                                      meme.titlePadding = value;
                                                      memeTools.sinkMeme(meme);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: SwitchListTile(
                                                  title: Text('Bold?'),
                                                  secondary: Icon(Icons
                                                      .font_download_outlined),
                                                  value: meme.titleStyle
                                                          .fontWeight ==
                                                      FontWeight.bold,
                                                  onChanged: (value) {
                                                    meme.titleStyle = meme
                                                        .titleStyle
                                                        .copyWith(
                                                            fontWeight: value
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal);
                                                    memeTools.sinkMeme(meme);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: ListTile(
                                                  title: Text('Text Direction'),
                                                  leading:
                                                      Icon(Icons.directions),
                                                  subtitle: Row(
                                                    children: [
                                                      Text("Left to Right"),
                                                      Radio<TextDirection>(
                                                        groupValue:
                                                            meme.titleDirection,
                                                        value:
                                                            TextDirection.ltr,
                                                        onChanged: (value) {
                                                          meme.titleDirection =
                                                              value;
                                                          memeTools
                                                              .sinkMeme(meme);
                                                        },
                                                      ),
                                                      Text("Right to Left"),
                                                      Radio<TextDirection>(
                                                        groupValue:
                                                            meme.titleDirection,
                                                        value:
                                                            TextDirection.rtl,
                                                        onChanged: (value) {
                                                          meme.titleDirection =
                                                              value;
                                                          memeTools
                                                              .sinkMeme(meme);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: ListTile(
                                                  title: Text('Text Alignment'),
                                                  leading: Icon(Icons
                                                      .format_align_center),
                                                  subtitle: Row(
                                                    children: [
                                                      Text("Start"),
                                                      Radio<TextAlign>(
                                                        groupValue:
                                                            meme.titleAlign,
                                                        value: TextAlign.start,
                                                        onChanged: (value) {
                                                          meme.titleAlign =
                                                              value;
                                                          memeTools
                                                              .sinkMeme(meme);
                                                        },
                                                      ),
                                                      Text("Center"),
                                                      Radio<TextAlign>(
                                                        groupValue:
                                                            meme.titleAlign,
                                                        value: TextAlign.center,
                                                        onChanged: (value) {
                                                          meme.titleAlign =
                                                              value;
                                                          memeTools
                                                              .sinkMeme(meme);
                                                        },
                                                      ),
                                                      Text("End"),
                                                      Radio<TextAlign>(
                                                        groupValue:
                                                            meme.titleAlign,
                                                        value: TextAlign.end,
                                                        onChanged: (value) {
                                                          meme.titleAlign =
                                                              value;
                                                          memeTools
                                                              .sinkMeme(meme);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                elevation: 4,
                                                child: ListTile(
                                                  title: Text('Title Color'),
                                                  leading:
                                                      Icon(Icons.color_lens),
                                                  trailing: Container(
                                                    height: 20,
                                                    width: 30,
                                                    color:
                                                        meme.titleStyle.color,
                                                  ),
                                                  onTap: () async {
                                                    var color =
                                                        await showColorPickerDialog(
                                                            context,
                                                            meme.titleStyle
                                                                .color);
                                                    meme.titleStyle = meme
                                                        .titleStyle
                                                        .copyWith(color: color);
                                                    memeTools.sinkMeme(meme);
                                                  },
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
                                      'topText': '',
                                      'bottomText': '',
                                      'topTextDirection': TextDirection.ltr,
                                      'bottomTextDirection': TextDirection.ltr,
                                      'topTextAlignment': TextAlign.center,
                                      'bottomTextAlignment': TextAlign.center,
                                      'topTextStyle': TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.12, 1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(1.12, -1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(-1.12, 1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(-1.12, -1.12),
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      'bottomTextStyle': TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.12, 1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(1.12, -1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(-1.12, 1.12),
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(-1.12, -1.12),
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
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
