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
import 'package:image_save/image_save.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:meme_creator_2/tools.dart';
import 'package:meme_creator_2/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'api_image_picker.dart';
import 'data.dart';

class MemeCreator extends StatefulWidget {
  @override
  _MemeCreatorState createState() => _MemeCreatorState();
}

class _MemeCreatorState extends State<MemeCreator> {
  ScreenshotController screenshotController = ScreenshotController();
  bool saveLoading = false;
  bool shareLoading = false;
  GlobalKey canvasKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future:
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      builder: (context, snap) => Scaffold(
        body: Center(
          child: StreamWidget<MemeData>(
            stream: memeTools.stream,
            widget: (context, meme) => meme.title.isEmpty && meme.images.isEmpty
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Add pictures and captions using the tools button from the bottom left corner.\n👇👇👇",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top,
                        bottom: 75,
                      ),
                      child: Screenshot(
                        controller: screenshotController,
                        child: Stack(
                          children: List.generate(
                            meme.floatingTexts.length + 1,
                            (index) {
                              if (index == 0) {
                                return Container(
                                  key: canvasKey,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  padding:
                                      EdgeInsets.all(meme.containerPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      meme.title != ""
                                          ? Padding(
                                              padding: EdgeInsets.all(
                                                  meme.titlePadding),
                                              child: Text(
                                                meme.title,
                                                style: meme.titleStyle,
                                                textAlign: meme.titleAlign,
                                                textDirection:
                                                    meme.titleDirection,
                                              ),
                                            )
                                          : Container(),
                                      Wrap(
                                        children: List.generate(
                                          meme.images.length,
                                          (index) => Padding(
                                            padding: EdgeInsets.all(
                                                meme.imagesPadding),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      meme.borderRadius),
                                              clipBehavior: Clip.antiAlias,
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    isScrollControlled: false,
                                                    builder: (context) {
                                                      TextEditingController
                                                          caption1 =
                                                          TextEditingController(
                                                              text: meme.images[
                                                                      index]
                                                                  ['topText']);
                                                      TextEditingController
                                                          caption2 =
                                                          TextEditingController(
                                                              text: meme.images[
                                                                      index][
                                                                  'bottomText']);
                                                      return StreamWidget<
                                                          MemeData>(
                                                        stream:
                                                            memeTools.stream,
                                                        widget:
                                                            (context, meme) =>
                                                                Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "Edit Captions",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline4,
                                                              ),
                                                            ),
                                                            Divider(
                                                              indent: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .2,
                                                              endIndent:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .2,
                                                              color:
                                                                  Colors.black,
                                                              thickness: 3,
                                                            ),
                                                            Expanded(
                                                              child: ListView(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          caption1,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      textCapitalization:
                                                                          TextCapitalization
                                                                              .characters,
                                                                      maxLines:
                                                                          null,
                                                                      textDirection:
                                                                          meme.images[index]
                                                                              [
                                                                              'topTextDirection'],
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            "Caption #1",
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.black),
                                                                        ),
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        meme.images[index]['topText'] =
                                                                            value;
                                                                        memeTools
                                                                            .sinkMeme(meme);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          caption2,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      maxLines:
                                                                          null,
                                                                      textDirection:
                                                                          meme.images[index]
                                                                              [
                                                                              'bottomTextDirection'],
                                                                      textCapitalization:
                                                                          TextCapitalization
                                                                              .characters,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            "Caption #2",
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.black),
                                                                        ),
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        meme.images[index]['bottomText'] =
                                                                            value;
                                                                        memeTools
                                                                            .sinkMeme(meme);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            'Caption Size'),
                                                                        leading:
                                                                            Icon(Icons.text_fields),
                                                                        subtitle:
                                                                            Slider(
                                                                          value:
                                                                              (meme.images[index]['topTextStyle'] as TextStyle).fontSize,
                                                                          max:
                                                                              50,
                                                                          min:
                                                                              10,
                                                                          divisions:
                                                                              40,
                                                                          label: (meme.images[index]['topTextStyle'] as TextStyle)
                                                                              .fontSize
                                                                              .toInt()
                                                                              .toString(),
                                                                          onChanged:
                                                                              (double value) {
                                                                            meme.images[index]['topTextStyle'] =
                                                                                (meme.images[index]['topTextStyle'] as TextStyle).copyWith(fontSize: value);
                                                                            meme.images[index]['bottomTextStyle'] =
                                                                                (meme.images[index]['bottomTextStyle'] as TextStyle).copyWith(fontSize: value);
                                                                            memeTools.sinkMeme(meme);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          SwitchListTile(
                                                                        title: Text(
                                                                            'Bold?'),
                                                                        secondary:
                                                                            Icon(Icons.format_bold),
                                                                        value: (meme.images[index]['topTextStyle'] as TextStyle).fontWeight ==
                                                                            FontWeight.bold,
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.images[index]
                                                                              [
                                                                              'topTextStyle'] = (meme.images[index]['topTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(fontWeight: value ? FontWeight.bold : FontWeight.normal);
                                                                          meme.images[index]
                                                                              [
                                                                              'bottomTextStyle'] = (meme.images[index]['bottomTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(fontWeight: value ? FontWeight.bold : FontWeight.normal);
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          SwitchListTile(
                                                                        title: Text(
                                                                            'Italic?'),
                                                                        secondary:
                                                                            Icon(Icons.format_italic),
                                                                        value: (meme.images[index]['topTextStyle'] as TextStyle).fontStyle ==
                                                                            FontStyle.italic,
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.images[index]
                                                                              [
                                                                              'topTextStyle'] = (meme.images[index]['topTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(fontStyle: value ? FontStyle.italic : FontStyle.normal);
                                                                          meme.images[index]
                                                                              [
                                                                              'bottomTextStyle'] = (meme.images[index]['bottomTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(fontStyle: value ? FontStyle.italic : FontStyle.normal);
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          SwitchListTile(
                                                                        title: Text(
                                                                            'Expanded?'),
                                                                        secondary:
                                                                            Icon(Icons.expand),
                                                                        value: meme.images[index]
                                                                            [
                                                                            'expanded'],
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.images[index]
                                                                              [
                                                                              'expanded'] = !meme
                                                                                  .images[index]
                                                                              [
                                                                              'expanded'];

                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            'Caption Direction'),
                                                                        leading:
                                                                            Icon(Icons.directions),
                                                                        subtitle:
                                                                            Row(
                                                                          children: [
                                                                            Text("Left to Right"),
                                                                            Radio<TextDirection>(
                                                                              groupValue: meme.images[index]['topTextDirection'],
                                                                              value: TextDirection.ltr,
                                                                              onChanged: (value) {
                                                                                meme.images[index]['topTextDirection'] = value;
                                                                                meme.images[index]['bottomTextDirection'] = value;
                                                                                memeTools.sinkMeme(meme);
                                                                              },
                                                                            ),
                                                                            Text("Right to Left"),
                                                                            Radio<TextDirection>(
                                                                              groupValue: meme.images[index]['topTextDirection'],
                                                                              value: TextDirection.rtl,
                                                                              onChanged: (value) {
                                                                                meme.images[index]['topTextDirection'] = value;
                                                                                meme.images[index]['bottomTextDirection'] = value;
                                                                                memeTools.sinkMeme(meme);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            'Text Alignment'),
                                                                        leading:
                                                                            Icon(Icons.format_align_center),
                                                                        subtitle:
                                                                            Row(
                                                                          children: [
                                                                            Text("Start"),
                                                                            Radio<TextAlign>(
                                                                              groupValue: meme.images[index]['topTextAlignment'],
                                                                              value: TextAlign.start,
                                                                              onChanged: (value) {
                                                                                meme.images[index]['topTextAlignment'] = value;
                                                                                meme.images[index]['bottomTextAlignment'] = value;
                                                                                memeTools.sinkMeme(meme);
                                                                              },
                                                                            ),
                                                                            Text("Center"),
                                                                            Radio<TextAlign>(
                                                                              groupValue: meme.images[index]['topTextAlignment'],
                                                                              value: TextAlign.center,
                                                                              onChanged: (value) {
                                                                                meme.images[index]['topTextAlignment'] = value;
                                                                                meme.images[index]['bottomTextAlignment'] = value;
                                                                                memeTools.sinkMeme(meme);
                                                                              },
                                                                            ),
                                                                            Text("End"),
                                                                            Radio<TextAlign>(
                                                                              groupValue: meme.images[index]['topTextAlignment'],
                                                                              value: TextAlign.end,
                                                                              onChanged: (value) {
                                                                                meme.images[index]['topTextAlignment'] = value;
                                                                                meme.images[index]['bottomTextAlignment'] = value;
                                                                                memeTools.sinkMeme(meme);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            'Captions Color'),
                                                                        leading:
                                                                            Icon(Icons.color_lens),
                                                                        trailing:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              30,
                                                                          color: meme
                                                                              .images[index]['topTextStyle']
                                                                              .color,
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          var color = await showColorPickerDialog(
                                                                              context,
                                                                              meme.titleStyle.color);
                                                                          meme.images[index]
                                                                              [
                                                                              'topTextStyle'] = (meme.images[index]['topTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(color: color);
                                                                          meme.images[index]
                                                                              [
                                                                              'bottomTextStyle'] = (meme.images[index]['bottomTextStyle']
                                                                                  as TextStyle)
                                                                              .copyWith(color: color);
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Material(
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      elevation:
                                                                          4,
                                                                      child:
                                                                          ListTile(
                                                                        title:
                                                                            Text(
                                                                          'Delete this Image?',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        tileColor:
                                                                            Colors.red,
                                                                        onTap:
                                                                            () async {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                title: Text('Are you sure?'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: Text('Cancel')),
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        meme.images.removeAt(index);
                                                                                        memeTools.sinkMeme(meme);
                                                                                        Navigator.of(context)..pop()..pop();
                                                                                      },
                                                                                      child: Text(
                                                                                        'Delete',
                                                                                        style: TextStyle(color: Colors.red),
                                                                                      )),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
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
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: meme.images[index]
                                                              ['expanded']
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              meme.imagesPadding *
                                                                  2 -
                                                              meme.containerPadding *
                                                                  2
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  .5 -
                                                              meme.imagesPadding *
                                                                  2 -
                                                              meme.containerPadding,
                                                      height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .7 *
                                                              meme.imageHeight *
                                                              .01 -
                                                          meme.imagesPadding *
                                                              2,
                                                      child: InteractiveViewer(
                                                        maxScale: 5,
                                                        constrained: false,
                                                        child: Image.memory(
                                                          meme.images[index]
                                                              ['data'],
                                                          width: meme.images[
                                                                      index]
                                                                  ['expanded']
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  meme.imagesPadding *
                                                                      2 -
                                                                  meme.containerPadding *
                                                                      2
                                                              : MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      .5 -
                                                                  meme.imagesPadding *
                                                                      2 -
                                                                  meme.containerPadding,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      width: meme.images[index]
                                                              ['expanded']
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              meme.imagesPadding *
                                                                  2
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  .5 -
                                                              meme.imagesPadding *
                                                                  2,
                                                      top: 5,
                                                      child: Text(
                                                        meme.images[index]
                                                            ['topText'],
                                                        style: meme
                                                                .images[index]
                                                            ['topTextStyle'],
                                                        textAlign: meme
                                                                .images[index][
                                                            'topTextAlignment'],
                                                        textDirection: meme
                                                                .images[index][
                                                            'topTextDirection'],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      width: meme.images[index]
                                                              ['expanded']
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              meme.imagesPadding *
                                                                  2
                                                          : MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  .5 -
                                                              meme.imagesPadding *
                                                                  2,
                                                      bottom: 5,
                                                      child: Text(
                                                        meme.images[index]
                                                            ['bottomText'],
                                                        style: meme
                                                                .images[index]
                                                            ['bottomTextStyle'],
                                                        textAlign: meme
                                                                .images[index][
                                                            'bottomTextAlignment'],
                                                        textDirection: meme
                                                                .images[index][
                                                            'bottomTextDirection'],
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
                                );
                              } else {
                                return Positioned(
                                  top: meme
                                      .floatingTexts[index - 1]['offset'].dy,
                                  left: meme
                                      .floatingTexts[index - 1]['offset'].dx,
                                  child: InkWell(
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
                                        isScrollControlled: false,
                                        builder: (context) {
                                          TextEditingController caption1 =
                                              TextEditingController(
                                                  text: meme.floatingTexts[
                                                      index - 1]['text']);
                                          return StreamWidget<MemeData>(
                                            stream: memeTools.stream,
                                            widget: (context, meme) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Edit Floating Text",
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
                                                  endIndent:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .2,
                                                  color: Colors.black,
                                                  thickness: 3,
                                                ),
                                                Expanded(
                                                  child: ListView(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextField(
                                                          controller: caption1,
                                                          maxLines: null,
                                                          textDirection:
                                                              meme.floatingTexts[
                                                                      index - 1]
                                                                  [
                                                                  'textDirection'],
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .sentences,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Write your text here",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                            ),
                                                          ),
                                                          onChanged: (value) {
                                                            meme.floatingTexts[
                                                                        index -
                                                                            1]
                                                                    ['text'] =
                                                                value;
                                                            memeTools
                                                                .sinkMeme(meme);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: ListTile(
                                                            title: Text(
                                                                'Caption Size'),
                                                            leading: Icon(Icons
                                                                .text_fields),
                                                            subtitle: Slider(
                                                              value: (meme.floatingTexts[index -
                                                                              1]
                                                                          [
                                                                          'textStyle']
                                                                      as TextStyle)
                                                                  .fontSize,
                                                              max: 50,
                                                              min: 10,
                                                              divisions: 40,
                                                              label: (meme.floatingTexts[index -
                                                                              1]
                                                                          [
                                                                          'textStyle']
                                                                      as TextStyle)
                                                                  .fontSize
                                                                  .toInt()
                                                                  .toString(),
                                                              onChanged: (double
                                                                  value) {
                                                                meme.floatingTexts[
                                                                        index -
                                                                            1]
                                                                    [
                                                                    'textStyle'] = (meme.floatingTexts[index -
                                                                                1]
                                                                            [
                                                                            'textStyle']
                                                                        as TextStyle)
                                                                    .copyWith(
                                                                        fontSize:
                                                                            value);
                                                                memeTools
                                                                    .sinkMeme(
                                                                        meme);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: SwitchListTile(
                                                            title:
                                                                Text('Bold?'),
                                                            secondary: Icon(Icons
                                                                .format_bold),
                                                            value: (meme.floatingTexts[index -
                                                                                1]
                                                                            [
                                                                            'textStyle']
                                                                        as TextStyle)
                                                                    .fontWeight ==
                                                                FontWeight.bold,
                                                            onChanged: (value) {
                                                              meme.floatingTexts[
                                                                      index - 1]
                                                                  ['textStyle'] = (meme.floatingTexts[index -
                                                                              1]
                                                                          ['textStyle']
                                                                      as TextStyle)
                                                                  .copyWith(
                                                                      fontWeight: value
                                                                          ? FontWeight
                                                                              .bold
                                                                          : FontWeight
                                                                              .normal);
                                                              memeTools
                                                                  .sinkMeme(
                                                                      meme);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: SwitchListTile(
                                                            title:
                                                                Text('Italic?'),
                                                            secondary: Icon(Icons
                                                                .format_italic),
                                                            value: (meme.floatingTexts[index -
                                                                                1]
                                                                            [
                                                                            'textStyle']
                                                                        as TextStyle)
                                                                    .fontStyle ==
                                                                FontStyle
                                                                    .italic,
                                                            onChanged: (value) {
                                                              meme.floatingTexts[
                                                                      index - 1]
                                                                  ['textStyle'] = (meme.floatingTexts[index -
                                                                              1]
                                                                          ['textStyle']
                                                                      as TextStyle)
                                                                  .copyWith(
                                                                      fontStyle: value
                                                                          ? FontStyle
                                                                              .italic
                                                                          : FontStyle
                                                                              .normal);
                                                              memeTools
                                                                  .sinkMeme(
                                                                      meme);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: ListTile(
                                                            title: Text(
                                                                'Caption Direction'),
                                                            leading: Icon(Icons
                                                                .directions),
                                                            subtitle: Row(
                                                              children: [
                                                                Text(
                                                                    "Left to Right"),
                                                                Radio<
                                                                    TextDirection>(
                                                                  groupValue: meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'textDirection'],
                                                                  value:
                                                                      TextDirection
                                                                          .ltr,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.floatingTexts[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'textDirection'] = value;
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                                Text(
                                                                    "Right to Left"),
                                                                Radio<
                                                                    TextDirection>(
                                                                  groupValue: meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'textDirection'],
                                                                  value:
                                                                      TextDirection
                                                                          .rtl,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.floatingTexts[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'textDirection'] = value;
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: ListTile(
                                                            title: Text(
                                                                'Text Alignment'),
                                                            leading: Icon(Icons
                                                                .format_align_center),
                                                            subtitle: Row(
                                                              children: [
                                                                Text("Start"),
                                                                Radio<
                                                                    TextAlign>(
                                                                  groupValue: meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'textAlignment'],
                                                                  value:
                                                                      TextAlign
                                                                          .start,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.floatingTexts[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'textAlignment'] = value;
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                                Text("Center"),
                                                                Radio<
                                                                    TextAlign>(
                                                                  groupValue: meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'textAlignment'],
                                                                  value: TextAlign
                                                                      .center,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.floatingTexts[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'textAlignment'] = value;
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                                Text("End"),
                                                                Radio<
                                                                    TextAlign>(
                                                                  groupValue: meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'textAlignment'],
                                                                  value:
                                                                      TextAlign
                                                                          .end,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.floatingTexts[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'textAlignment'] = value;
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 4,
                                                          child: ListTile(
                                                            title: Text(
                                                                'Captions Color'),
                                                            leading: Icon(Icons
                                                                .color_lens),
                                                            trailing: Container(
                                                              height: 20,
                                                              width: 30,
                                                              color: meme
                                                                  .floatingTexts[
                                                                      index - 1]
                                                                      [
                                                                      'textStyle']
                                                                  .color,
                                                            ),
                                                            onTap: () async {
                                                              var color = await showColorPickerDialog(
                                                                  context,
                                                                  meme
                                                                      .floatingTexts[
                                                                          index -
                                                                              1]
                                                                          [
                                                                          'textStyle']
                                                                      .color);
                                                              meme.floatingTexts[
                                                                      index - 1]
                                                                  [
                                                                  'textStyle'] = (meme
                                                                              .floatingTexts[
                                                                          index -
                                                                              1]['textStyle']
                                                                      as TextStyle)
                                                                  .copyWith(
                                                                      color:
                                                                          color);
                                                              memeTools
                                                                  .sinkMeme(
                                                                      meme);
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
                                    child: Draggable(
                                      child: Text(
                                        meme.floatingTexts[index - 1]['text'],
                                        textAlign: meme.floatingTexts[index - 1]
                                            ['textAlignment'],
                                        textDirection:
                                            meme.floatingTexts[index - 1]
                                                ['textDirection'],
                                        style: meme.floatingTexts[index - 1]
                                            ['textStyle'],
                                      ),
                                      onDragEnd: (details) {
                                        var obj = canvasKey.currentContext;
                                        var box =
                                            obj.findRenderObject() as RenderBox;
                                        Offset of;
                                        if (MediaQuery.of(context)
                                                .size
                                                .height >=
                                            (box.size.height +
                                                MediaQuery.of(context)
                                                    .viewPadding
                                                    .top)) {
                                          of = Offset(
                                              details.offset.dx,
                                              details.offset.dy +
                                                  5.5 +
                                                  scrollController.offset -
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .height -
                                                          (box.size.height +
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewPadding
                                                                  .top)) /
                                                      2);
                                        } else {
                                          of = Offset(
                                              details.offset.dx,
                                              details.offset.dy +
                                                  5.5 +
                                                  scrollController.offset -
                                                  75 / 2);
                                        }
                                        meme.floatingTexts[index - 1]
                                            ['offset'] = of;
                                        memeTools.sinkMeme(meme);
                                        print(of);
                                        print(
                                            MediaQuery.of(context).viewPadding);
                                      },
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          meme.floatingTexts[index - 1]['text'],
                                          textAlign:
                                              meme.floatingTexts[index - 1]
                                                  ['textAlignment'],
                                          textDirection:
                                              meme.floatingTexts[index - 1]
                                                  ['textDirection'],
                                          style: meme.floatingTexts[index - 1]
                                              ['textStyle'],
                                        ),
                                      ),
                                      childWhenDragging: Container(),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
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
                  isScrollControlled: false,
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
                          Expanded(
                            child: ListView(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          clipBehavior: Clip.antiAlias,
                                          child: ListTile(
                                            title: Text("Meme Title"),
                                            leading:
                                                Icon(Icons.article_outlined),
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                clipBehavior: Clip.antiAlias,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                isScrollControlled: false,
                                                builder: (context) {
                                                  TextEditingController
                                                      textEditingController =
                                                      TextEditingController(
                                                          text: meme.title);
                                                  return StreamWidget<MemeData>(
                                                    stream: memeTools.stream,
                                                    widget: (context, meme) =>
                                                        Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Meme Title",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4,
                                                          ),
                                                        ),
                                                        Divider(
                                                          indent: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                          endIndent:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .2,
                                                          color: Colors.black,
                                                          thickness: 3,
                                                        ),
                                                        Expanded(
                                                            child: ListView(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    textEditingController,
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .sentences,
                                                                maxLines: null,
                                                                textDirection: meme
                                                                    .titleDirection,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Write the meme title here",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.black),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  meme.title =
                                                                      value;
                                                                  memeTools
                                                                      .sinkMeme(
                                                                          meme);
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      'Title Size'),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .text_fields),
                                                                  subtitle:
                                                                      Slider(
                                                                    value: meme
                                                                        .titleStyle
                                                                        .fontSize,
                                                                    max: 75,
                                                                    min: 14,
                                                                    divisions:
                                                                        61,
                                                                    label: meme
                                                                        .titleStyle
                                                                        .fontSize
                                                                        .toInt()
                                                                        .toString(),
                                                                    onChanged:
                                                                        (double
                                                                            value) {
                                                                      meme.titleStyle = meme
                                                                          .titleStyle
                                                                          .copyWith(
                                                                        fontSize:
                                                                            value,
                                                                      );
                                                                      memeTools
                                                                          .sinkMeme(
                                                                              meme);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      'Title Padding'),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .space_bar),
                                                                  subtitle:
                                                                      Slider(
                                                                    value: meme
                                                                        .titlePadding,
                                                                    max: 40,
                                                                    min: 0,
                                                                    divisions:
                                                                        40,
                                                                    label: meme
                                                                        .titlePadding
                                                                        .toInt()
                                                                        .toString(),
                                                                    onChanged:
                                                                        (double
                                                                            value) {
                                                                      meme.titlePadding =
                                                                          value;
                                                                      memeTools
                                                                          .sinkMeme(
                                                                              meme);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child:
                                                                    SwitchListTile(
                                                                  title: Text(
                                                                      'Bold?'),
                                                                  secondary:
                                                                      Icon(Icons
                                                                          .format_bold),
                                                                  value: meme
                                                                          .titleStyle
                                                                          .fontWeight ==
                                                                      FontWeight
                                                                          .bold,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.titleStyle = meme
                                                                        .titleStyle
                                                                        .copyWith(
                                                                            fontWeight: value
                                                                                ? FontWeight.bold
                                                                                : FontWeight.normal);
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child:
                                                                    SwitchListTile(
                                                                  title: Text(
                                                                      'Italic?'),
                                                                  secondary:
                                                                      Icon(Icons
                                                                          .format_italic),
                                                                  value: meme
                                                                          .titleStyle
                                                                          .fontStyle ==
                                                                      FontStyle
                                                                          .italic,
                                                                  onChanged:
                                                                      (value) {
                                                                    meme.titleStyle = meme
                                                                        .titleStyle
                                                                        .copyWith(
                                                                            fontStyle: value
                                                                                ? FontStyle.italic
                                                                                : FontStyle.normal);
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      'Text Direction'),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .directions),
                                                                  subtitle: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Left to Right"),
                                                                      Radio<
                                                                          TextDirection>(
                                                                        groupValue:
                                                                            meme.titleDirection,
                                                                        value: TextDirection
                                                                            .ltr,
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.titleDirection =
                                                                              value;
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                          "Right to Left"),
                                                                      Radio<
                                                                          TextDirection>(
                                                                        groupValue:
                                                                            meme.titleDirection,
                                                                        value: TextDirection
                                                                            .rtl,
                                                                        onChanged:
                                                                            (value) {
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
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      'Text Alignment'),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .format_align_center),
                                                                  subtitle: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Start"),
                                                                      Radio<
                                                                          TextAlign>(
                                                                        groupValue:
                                                                            meme.titleAlign,
                                                                        value: TextAlign
                                                                            .start,
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.titleAlign =
                                                                              value;
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                          "Center"),
                                                                      Radio<
                                                                          TextAlign>(
                                                                        groupValue:
                                                                            meme.titleAlign,
                                                                        value: TextAlign
                                                                            .center,
                                                                        onChanged:
                                                                            (value) {
                                                                          meme.titleAlign =
                                                                              value;
                                                                          memeTools
                                                                              .sinkMeme(meme);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                          "End"),
                                                                      Radio<
                                                                          TextAlign>(
                                                                        groupValue:
                                                                            meme.titleAlign,
                                                                        value: TextAlign
                                                                            .end,
                                                                        onChanged:
                                                                            (value) {
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
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                elevation: 4,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      'Title Color'),
                                                                  leading: Icon(
                                                                      Icons
                                                                          .color_lens),
                                                                  trailing:
                                                                      Container(
                                                                    height: 20,
                                                                    width: 30,
                                                                    color: meme
                                                                        .titleStyle
                                                                        .color,
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    var color = await showColorPickerDialog(
                                                                        context,
                                                                        meme.titleStyle
                                                                            .color);
                                                                    meme.titleStyle = meme
                                                                        .titleStyle
                                                                        .copyWith(
                                                                            color:
                                                                                color);
                                                                    memeTools
                                                                        .sinkMeme(
                                                                            meme);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          clipBehavior: Clip.antiAlias,
                                          child: ListTile(
                                            title: Text("Add Pictures"),
                                            // subtitle: Text("From Device"),
                                            leading: Icon(Icons.image),
                                            onTap: () async {
                                              var fs = await MultiMediaPicker
                                                  .pickImages();
                                              int i = 0;
                                              fs.forEach((element) {
                                                meme.images.add({
                                                  'data':
                                                      element.readAsBytesSync(),
                                                  'index': i,
                                                  'expanded': false,
                                                  'topText': '',
                                                  'bottomText': '',
                                                  'topTextDirection':
                                                      TextDirection.ltr,
                                                  'bottomTextDirection':
                                                      TextDirection.ltr,
                                                  'topTextAlignment':
                                                      TextAlign.center,
                                                  'bottomTextAlignment':
                                                      TextAlign.center,
                                                  'topTextStyle': TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        offset:
                                                            Offset(1.12, 1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(1.12, -1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(-1.12, 1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset: Offset(
                                                            -1.12, -1.12),
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  'bottomTextStyle': TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        offset:
                                                            Offset(1.12, 1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(1.12, -1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(-1.12, 1.12),
                                                        color: Colors.black,
                                                      ),
                                                      Shadow(
                                                        offset: Offset(
                                                            -1.12, -1.12),
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                });
                                                i++;
                                              });
                                              if (fs.length % 2 == 1)
                                                meme.images[meme.images.length -
                                                    1]['expanded'] = true;
                                              memeTools.sinkMeme(meme);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          clipBehavior: Clip.antiAlias,
                                          child: ListTile(
                                            title: Text("Floating Text"),
                                            leading: Icon(Icons.article),
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String m = "";
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text(
                                                        'Add a Floating text'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Add Text"),
                                                        onPressed: () {
                                                          var b = canvasKey
                                                                  .currentContext
                                                                  .findRenderObject()
                                                              as RenderBox;
                                                          if (m.isNotEmpty) {
                                                            meme.floatingTexts
                                                                .add({
                                                              "text": m,
                                                              "index": meme
                                                                  .floatingTexts
                                                                  .length,
                                                              "textAlignment":
                                                                  TextAlign
                                                                      .center,
                                                              "textDirection":
                                                                  TextDirection
                                                                      .ltr,
                                                              "offset": Offset(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .5,
                                                                b.size.height /
                                                                    2,
                                                              ),
                                                              "textStyle":
                                                                  TextStyle(
                                                                fontSize: 30,
                                                                color: Colors
                                                                    .white,
                                                                shadows: [
                                                                  Shadow(
                                                                    offset: Offset(
                                                                        1.12,
                                                                        1.12),
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Shadow(
                                                                    offset: Offset(
                                                                        1.12,
                                                                        -1.12),
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Shadow(
                                                                    offset: Offset(
                                                                        -1.12,
                                                                        1.12),
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Shadow(
                                                                    offset: Offset(
                                                                        -1.12,
                                                                        -1.12),
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ],
                                                              ),
                                                            });
                                                            memeTools
                                                                .sinkMeme(meme);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                    ],
                                                    content: TextField(
                                                      onChanged: (v) {
                                                        m = v;
                                                      },
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          clipBehavior: Clip.antiAlias,
                                          child: ListTile(
                                            title: Text("Pick Image"),
                                            subtitle: Text("From the Internet"),
                                            leading:
                                                Icon(Icons.add_photo_alternate),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApiImagePicker(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                        value: memeTools.data.containerPadding,
                                        divisions: 20,
                                        label: memeTools.data.containerPadding
                                            .toInt()
                                            .toString(),
                                        max: 20,
                                        min: 0,
                                        onChanged: (value) {
                                          meme.containerPadding = value;
                                          memeTools.sinkMeme(meme);
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
                                        value: memeTools.data.imagesPadding,
                                        divisions: 20,
                                        label: memeTools.data.imagesPadding
                                            .toInt()
                                            .toString(),
                                        max: 20,
                                        min: 0,
                                        onChanged: (value) {
                                          meme.imagesPadding = value;
                                          memeTools.sinkMeme(meme);
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
                                        value: meme.borderRadius,
                                        min: 0,
                                        max: 45,
                                        divisions: 45,
                                        label: meme.borderRadius
                                            .toInt()
                                            .toString(),
                                        onChanged: (value) {
                                          meme.borderRadius = value;
                                          memeTools.sinkMeme(meme);
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
                                          memeTools.sinkMeme(meme);
                                        },
                                      ),
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
            Padding(
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
                        print(onError);
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
                        print(onError);
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
      ),
    );
  }
}
