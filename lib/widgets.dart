import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:meme_creator_2/tools.dart';
import 'package:screenshot/screenshot.dart';

//import 'package:image/image.dart' as img;

import 'data.dart';

class StreamWidget<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget Function(BuildContext context, T? data)? widget;
  final Widget Function(Object? error)? onError;
  final Widget Function()? onWait;
  const StreamWidget({
    this.stream,
    this.widget,
    this.onError,
    this.onWait,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return widget!(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError == null)
            return Center(
              child: Text("Error while loading data:\n${snapshot.error}"),
            );
          else
            return onError!(snapshot.error);
        } else {
          if (onWait == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return onWait!();
        }
      },
    );
  }
}

class FutureWidget<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function(BuildContext context, T? data)? widget;
  final Widget Function(Object? error)? onError;
  final Widget Function()? onWait;
  const FutureWidget({this.future, this.widget, this.onError, this.onWait});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return widget!(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError == null)
            return Center(
              child: Text("Error while loading data:\n${snapshot.error}"),
            );
          else
            return onError!(snapshot.error);
        } else {
          if (onWait == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return onWait!();
        }
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final String? imgurl;
  final String title;
  final String? description;
  final double size;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final int descriptionLines;
  final double radius;
  final void Function()? onTap;
  NewsCard({
    this.size = 100,
    this.color,
    this.radius = 5,
    this.backgroundColor,
    this.description = "",
    this.descriptionStyle,
    this.titleStyle,
    this.title = "",
    this.onTap,
    this.descriptionLines = 1,
    this.imgurl =
        "https://previews.123rf.com/images/fordzolo/fordzolo1506/fordzolo150600296/41026708-example-white-stamp-text-on-red-backgroud.jpg",
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      color: color ?? Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imgurl!,
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
              Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor ?? Colors.black87,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: titleStyle ??
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: color ?? Colors.white,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        description!,
                        textAlign: TextAlign.left,
                        style: descriptionStyle ??
                            TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: color ?? Colors.white,
                            ),
                        maxLines: descriptionLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget memeFace(
    BuildContext context, Map<String, dynamic> memeData, MemeTools memeTools) {
  var meme = memeTools.data;
  return Stack(
    children: [
      Container(
        width: memeData['expanded']
            ? MediaQuery.of(context).size.width -
                meme.imagesPadding * 2 -
                meme.containerPadding * 2
            : MediaQuery.of(context).size.width * .5 -
                meme.imagesPadding * 2 -
                meme.containerPadding,
        height: (memeData['expanded']
                ? meme.expandedImageHeight! * meme.imageHeight * .01
                : meme.unexpandedImageHeight! * meme.imageHeight * .01) -
            meme.imagesPadding * 2 -
            meme.containerPadding *
                2, //I'm not quite sure about this value, u may delete it or change it later
        child: InteractiveViewer(
          maxScale: 5,
          constrained: false,
          child: Image.memory(
            memeData['data'],
            width: memeData['expanded']
                ? MediaQuery.of(context).size.width -
                    meme.imagesPadding * 2 -
                    meme.containerPadding * 2
                : MediaQuery.of(context).size.width * .5 -
                    meme.imagesPadding * 2 -
                    meme.containerPadding,
            fit: BoxFit.contain,
          ),
        ),
      ),
      Positioned(
        width: memeData['expanded']
            ? MediaQuery.of(context).size.width - meme.imagesPadding * 2
            : MediaQuery.of(context).size.width * .5 - meme.imagesPadding * 2,
        top: 5,
        child: Text(
          memeData['topText'],
          style: memeData['topTextStyle'],
          textAlign: memeData['topTextAlignment'],
          textDirection: memeData['topTextDirection'],
        ),
      ),
      Positioned(
        width: memeData['expanded']
            ? MediaQuery.of(context).size.width - meme.imagesPadding * 2
            : MediaQuery.of(context).size.width * .5 - meme.imagesPadding * 2,
        bottom: 5,
        child: Text(
          memeData['bottomText'],
          style: memeData['bottomTextStyle'],
          textAlign: memeData['bottomTextAlignment'],
          textDirection: memeData['bottomTextDirection'],
        ),
      ),
    ],
  );
}

Future bottomSheet(
  BuildContext context,
  Widget Function(BuildContext context) builder,
) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.white,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          child: builder(context),
        ),
      );
    },
  );
}

Widget imageSheet(
    BuildContext context, Map<String, dynamic> memeData, MemeTools memeTools) {
  var deviceWidth = MediaQuery.of(context).size.width;
  TextEditingController caption1 =
      TextEditingController(text: memeData['topText']);
  TextEditingController caption2 =
      TextEditingController(text: memeData['bottomText']);
  caption1.selection = TextSelection(
    baseOffset: caption1.text.length,
    extentOffset: caption1.text.length,
  );
  caption2.selection = TextSelection(
    baseOffset: caption2.text.length,
    extentOffset: caption2.text.length,
  );
  int? index = memeData['index'];
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
            style: Theme.of(context).textTheme.headlineMedium,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: caption1,
                  keyboardType: TextInputType.multiline,
                  // textCapitalization: TextCapitalization.characters,
                  maxLines: null,
                  textDirection: memeData['topTextDirection'],
                  decoration: InputDecoration(
                    hintText: "Caption #1",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  onChanged: (value) {
                    memeData['topText'] = value;
                    memeTools.sinkMeme(meme!, deviceWidth);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: caption2,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textDirection: memeData['bottomTextDirection'],
                  // textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: "Caption #2",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  onChanged: (value) {
                    memeData['bottomText'] = value;
                    memeTools.sinkMeme(meme!, deviceWidth);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Caption Size'),
                    leading: Icon(Icons.text_fields),
                    subtitle: Slider(
                      value: (memeData['topTextStyle'] as TextStyle).fontSize!,
                      max: 50,
                      min: 10,
                      divisions: 40,
                      label: (memeData['topTextStyle'] as TextStyle)
                          .fontSize!
                          .toInt()
                          .toString(),
                      onChanged: (double value) {
                        memeData['topTextStyle'] =
                            (memeData['topTextStyle'] as TextStyle)
                                .copyWith(fontSize: value);
                        memeData['bottomTextStyle'] =
                            (memeData['bottomTextStyle'] as TextStyle)
                                .copyWith(fontSize: value);
                        memeTools.sinkMeme(meme!, deviceWidth);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: SwitchListTile(
                    title: Text('Bold?'),
                    secondary: Icon(Icons.format_bold),
                    value: (memeData['topTextStyle'] as TextStyle).fontWeight ==
                        FontWeight.bold,
                    onChanged: (value) {
                      memeData['topTextStyle'] =
                          (memeData['topTextStyle'] as TextStyle).copyWith(
                              fontWeight:
                                  value ? FontWeight.bold : FontWeight.normal);
                      memeData['bottomTextStyle'] =
                          (memeData['bottomTextStyle'] as TextStyle).copyWith(
                              fontWeight:
                                  value ? FontWeight.bold : FontWeight.normal);
                      memeTools.sinkMeme(meme!, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: SwitchListTile(
                    title: Text('Italic?'),
                    secondary: Icon(Icons.format_italic),
                    value: (memeData['topTextStyle'] as TextStyle).fontStyle ==
                        FontStyle.italic,
                    onChanged: (value) {
                      memeData['topTextStyle'] =
                          (memeData['topTextStyle'] as TextStyle).copyWith(
                              fontStyle:
                                  value ? FontStyle.italic : FontStyle.normal);
                      memeData['bottomTextStyle'] =
                          (memeData['bottomTextStyle'] as TextStyle).copyWith(
                              fontStyle:
                                  value ? FontStyle.italic : FontStyle.normal);
                      memeTools.sinkMeme(meme!, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: SwitchListTile(
                    title: Text('Expanded?'),
                    secondary: Icon(Icons.expand),
                    value: memeData['expanded'],
                    onChanged: (value) {
                      memeData['expanded'] = !memeData['expanded'];

                      memeTools.sinkMeme(meme!, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Caption Direction'),
                    leading: Icon(Icons.directions),
                    subtitle: Row(
                      children: [
                        Text("Left to Right"),
                        Radio<TextDirection>(
                          groupValue: memeData['topTextDirection'],
                          value: TextDirection.ltr,
                          onChanged: (value) {
                            memeData['topTextDirection'] = value;
                            memeData['bottomTextDirection'] = value;
                            memeTools.sinkMeme(meme!, deviceWidth);
                          },
                        ),
                        Text("Right to Left"),
                        Radio<TextDirection>(
                          groupValue: memeData['topTextDirection'],
                          value: TextDirection.rtl,
                          onChanged: (value) {
                            memeData['topTextDirection'] = value;
                            memeData['bottomTextDirection'] = value;
                            memeTools.sinkMeme(meme!, deviceWidth);
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
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Text Alignment'),
                    leading: Icon(Icons.format_align_center),
                    subtitle: Row(
                      children: [
                        Text("Start"),
                        Radio<TextAlign>(
                          groupValue: memeData['topTextAlignment'],
                          value: TextAlign.start,
                          onChanged: (value) {
                            memeData['topTextAlignment'] = value;
                            memeData['bottomTextAlignment'] = value;
                            memeTools.sinkMeme(meme!, deviceWidth);
                          },
                        ),
                        Text("Center"),
                        Radio<TextAlign>(
                          groupValue: memeData['topTextAlignment'],
                          value: TextAlign.center,
                          onChanged: (value) {
                            memeData['topTextAlignment'] = value;
                            memeData['bottomTextAlignment'] = value;
                            memeTools.sinkMeme(meme!, deviceWidth);
                          },
                        ),
                        Text("End"),
                        Radio<TextAlign>(
                          groupValue: memeData['topTextAlignment'],
                          value: TextAlign.end,
                          onChanged: (value) {
                            memeData['topTextAlignment'] = value;
                            memeData['bottomTextAlignment'] = value;
                            memeTools.sinkMeme(meme!, deviceWidth);
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
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Captions Color'),
                    leading: Icon(Icons.color_lens),
                    trailing: Container(
                      height: 20,
                      width: 30,
                      color: memeData['topTextStyle'].color,
                    ),
                    onTap: () async {
                      var color = await showColorPickerDialog(
                          context, meme!.titleStyle.color!);
                      memeData['topTextStyle'] =
                          (memeData['topTextStyle'] as TextStyle)
                              .copyWith(color: color);
                      memeData['bottomTextStyle'] =
                          (memeData['bottomTextStyle'] as TextStyle)
                              .copyWith(color: color);
                      memeTools.sinkMeme(meme, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      'Delete this Image?',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    tileColor: Colors.red,
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
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
                                    // meme!.images.removeAt(index);
                                    meme!.images.removeWhere(
                                        (element) => element["index"] == index);
                                    meme.expandedImageHeight = null;
                                    meme.unexpandedImageHeight = null;
                                    memeTools.imageHeightOperation(
                                        meme, deviceWidth);
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop();
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
}

Widget listTileMaterial(Widget child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 4,
      child: child,
    ),
  );
}

Widget floatingTextAlert(
  GlobalKey canvasKey,
  MemeData meme,
  BuildContext context,
  MemeTools? memeTools,
) {
  var deviceWidth = MediaQuery.of(context).size.width;
  String m = "";
  return AlertDialog(
    backgroundColor: Colors.white,
    title: Text('Add a Floating text'),
    actions: [
      TextButton(
        child: Text("Add Text"),
        onPressed: () {
          var b = canvasKey.currentContext!.findRenderObject() as RenderBox?;
          if (m.isNotEmpty) {
            meme.floatingTexts.add({
              "text": m,
              "index": meme.floatingTexts.length,
              "textAlignment": TextAlign.center,
              "textDirection": TextDirection.ltr,
              "offset": Offset(
                MediaQuery.of(context).size.width * .5,
                b!.size.height / 2,
              ),
              "textStyle": TextStyle(
                fontSize: 30,
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
            memeTools!.sinkMeme(meme, deviceWidth);
            Navigator.of(context).pop();
          }
        },
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
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
}

Widget memeTitleSheet(MemeData meme, MemeTools memeTools) {
  TextEditingController textEditingController =
      TextEditingController(text: meme.title);
  textEditingController.selection = TextSelection(
    baseOffset: meme.title.length,
    extentOffset: meme.title.length,
  );
  return StreamWidget<MemeData>(
    stream: memeTools.stream,
    widget: (context, meme) {
      var deviceWidth = MediaQuery.of(context).size.width;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Meme Title",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  textDirection: meme!.titleDirection,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Write the meme title here",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   borderSide: BorderSide(
                    //     color: Theme.of(context).primaryColor,
                    //   ),
                    // ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  onChanged: (value) {
                    meme.title = value;
                    memeTools.sinkMeme(meme, deviceWidth);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Title Size'),
                    leading: Icon(Icons.text_fields),
                    subtitle: Slider(
                      value: meme.titleStyle.fontSize!,
                      max: 75,
                      min: 14,
                      divisions: 61,
                      label: meme.titleStyle.fontSize!.toInt().toString(),
                      onChanged: (double value) {
                        meme.titleStyle = meme.titleStyle.copyWith(
                          fontSize: value,
                        );
                        memeTools.sinkMeme(meme, deviceWidth);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Title Padding'),
                    leading: Icon(Icons.space_bar),
                    subtitle: Slider(
                      value: meme.titlePadding,
                      max: 40,
                      min: 0,
                      divisions: 40,
                      label: meme.titlePadding.toInt().toString(),
                      onChanged: (double value) {
                        meme.titlePadding = value;
                        memeTools.sinkMeme(meme, deviceWidth);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: SwitchListTile(
                    title: Text('Bold?'),
                    secondary: Icon(Icons.format_bold),
                    value: meme.titleStyle.fontWeight == FontWeight.bold,
                    onChanged: (value) {
                      meme.titleStyle = meme.titleStyle.copyWith(
                          fontWeight:
                              value ? FontWeight.bold : FontWeight.normal);
                      memeTools.sinkMeme(meme, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: SwitchListTile(
                    title: Text('Italic?'),
                    secondary: Icon(Icons.format_italic),
                    value: meme.titleStyle.fontStyle == FontStyle.italic,
                    onChanged: (value) {
                      meme.titleStyle = meme.titleStyle.copyWith(
                          fontStyle:
                              value ? FontStyle.italic : FontStyle.normal);
                      memeTools.sinkMeme(meme, deviceWidth);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Text Direction'),
                    leading: Icon(Icons.directions),
                    subtitle: Row(
                      children: [
                        Text("Left to Right"),
                        Radio<TextDirection>(
                          groupValue: meme.titleDirection,
                          value: TextDirection.ltr,
                          onChanged: (value) {
                            meme.titleDirection = value;
                            memeTools.sinkMeme(meme, deviceWidth);
                          },
                        ),
                        Text("Right to Left"),
                        Radio<TextDirection>(
                          groupValue: meme.titleDirection,
                          value: TextDirection.rtl,
                          onChanged: (value) {
                            meme.titleDirection = value;
                            memeTools.sinkMeme(meme, deviceWidth);
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
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Text Alignment'),
                    leading: Icon(Icons.format_align_center),
                    subtitle: Row(
                      children: [
                        Text("Start"),
                        Radio<TextAlign>(
                          groupValue: meme.titleAlign,
                          value: TextAlign.start,
                          onChanged: (value) {
                            meme.titleAlign = value;
                            memeTools.sinkMeme(meme, deviceWidth);
                          },
                        ),
                        Text("Center"),
                        Radio<TextAlign>(
                          groupValue: meme.titleAlign,
                          value: TextAlign.center,
                          onChanged: (value) {
                            meme.titleAlign = value;
                            memeTools.sinkMeme(meme, deviceWidth);
                          },
                        ),
                        Text("End"),
                        Radio<TextAlign>(
                          groupValue: meme.titleAlign,
                          value: TextAlign.end,
                          onChanged: (value) {
                            meme.titleAlign = value;
                            memeTools.sinkMeme(meme, deviceWidth);
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
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Title Color'),
                    leading: Icon(Icons.color_lens),
                    trailing: Container(
                      height: 20,
                      width: 30,
                      color: meme.titleStyle.color,
                    ),
                    onTap: () async {
                      var color = await showColorPickerDialog(
                          context, meme.titleStyle.color!);
                      meme.titleStyle = meme.titleStyle.copyWith(color: color);
                      memeTools.sinkMeme(meme, deviceWidth);
                    },
                  ),
                ),
              ),
            ],
          )),
        ],
      );
    },
  );
}

Future<void> addImagesFromDevice(
    MemeData meme, double deviceWidth, MemeTools memeTools) async {
  // var fs = await (MultiMediaPicker.pickImages());
  // var fs = controller.images;
  var files = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
    withData: true,
  );
  if (files != null) {
    int i = 0;
    files.files.forEach((element) {
      meme.images.add({
        'data': element.bytes,
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
    if (files.files.length % 2 == 1)
      meme.images[meme.images.length - 1]['expanded'] = true;
    // memeTools.sinkMeme(meme!, deviceWidth);
    memeTools.imageHeightOperation(meme, deviceWidth);
  }
}

Widget floatingTextSheet(
    BuildContext context, MemeData meme, int index, MemeTools memeTools) {
  TextEditingController caption1 =
      TextEditingController(text: meme.floatingTexts[index - 1]['text']);
  caption1.selection = TextSelection(
    baseOffset: meme.floatingTexts[index - 1]['text'].length,
    extentOffset: meme.floatingTexts[index - 1]['text'].length,
  );
  var deviceWidth = MediaQuery.of(context).size.width;
  return StreamWidget<MemeData>(
    stream: memeTools.stream,
    widget: (context, meme) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Edit Floating Text",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: caption1,
                  maxLines: null,
                  textDirection: meme!.floatingTexts[index - 1]
                      ['textDirection'],
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Write your text here",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    //   borderSide: BorderSide(color: Colors.black),
                    // ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  onChanged: (value) {
                    meme.floatingTexts[index - 1]['text'] = value;
                    memeTools.sinkMeme(meme, deviceWidth);
                  },
                ),
              ),
              listTileMaterial(
                ListTile(
                  title: Text('Caption Size'),
                  leading: Icon(Icons.text_fields),
                  subtitle: Slider(
                    value: (meme.floatingTexts[index - 1]['textStyle']
                            as TextStyle)
                        .fontSize!,
                    max: 50,
                    min: 10,
                    divisions: 40,
                    label: (meme.floatingTexts[index - 1]['textStyle']
                            as TextStyle)
                        .fontSize!
                        .toInt()
                        .toString(),
                    onChanged: (double value) {
                      meme.floatingTexts[index - 1]['textStyle'] =
                          (meme.floatingTexts[index - 1]['textStyle']
                                  as TextStyle)
                              .copyWith(fontSize: value);
                      memeTools.sinkMeme(meme, deviceWidth);
                    },
                  ),
                ),
              ),
              listTileMaterial(
                SwitchListTile(
                  title: Text('Bold?'),
                  secondary: Icon(Icons.format_bold),
                  value:
                      (meme.floatingTexts[index - 1]['textStyle'] as TextStyle)
                              .fontWeight ==
                          FontWeight.bold,
                  onChanged: (value) {
                    meme.floatingTexts[index - 1]['textStyle'] = (meme
                            .floatingTexts[index - 1]['textStyle'] as TextStyle)
                        .copyWith(
                            fontWeight:
                                value ? FontWeight.bold : FontWeight.normal);
                    memeTools.sinkMeme(meme, deviceWidth);
                  },
                ),
              ),
              listTileMaterial(
                SwitchListTile(
                  title: Text('Italic?'),
                  secondary: Icon(Icons.format_italic),
                  value:
                      (meme.floatingTexts[index - 1]['textStyle'] as TextStyle)
                              .fontStyle ==
                          FontStyle.italic,
                  onChanged: (value) {
                    meme.floatingTexts[index - 1]['textStyle'] = (meme
                            .floatingTexts[index - 1]['textStyle'] as TextStyle)
                        .copyWith(
                            fontStyle:
                                value ? FontStyle.italic : FontStyle.normal);
                    memeTools.sinkMeme(meme, deviceWidth);
                  },
                ),
              ),
              listTileMaterial(
                ListTile(
                  title: Text('Caption Direction'),
                  leading: Icon(Icons.directions),
                  subtitle: Row(
                    children: [
                      Text("Left to Right"),
                      Radio<TextDirection>(
                        groupValue: meme.floatingTexts[index - 1]
                            ['textDirection'],
                        value: TextDirection.ltr,
                        onChanged: (value) {
                          meme.floatingTexts[index - 1]['textDirection'] =
                              value;
                          memeTools.sinkMeme(meme, deviceWidth);
                        },
                      ),
                      Text("Right to Left"),
                      Radio<TextDirection>(
                        groupValue: meme.floatingTexts[index - 1]
                            ['textDirection'],
                        value: TextDirection.rtl,
                        onChanged: (value) {
                          meme.floatingTexts[index - 1]['textDirection'] =
                              value;
                          memeTools.sinkMeme(meme, deviceWidth);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              listTileMaterial(
                ListTile(
                  title: Text('Text Alignment'),
                  leading: Icon(Icons.format_align_center),
                  subtitle: Row(
                    children: [
                      Text("Start"),
                      Radio<TextAlign>(
                        groupValue: meme.floatingTexts[index - 1]
                            ['textAlignment'],
                        value: TextAlign.start,
                        onChanged: (value) {
                          meme.floatingTexts[index - 1]['textAlignment'] =
                              value;
                          memeTools.sinkMeme(meme, deviceWidth);
                        },
                      ),
                      Text("Center"),
                      Radio<TextAlign>(
                        groupValue: meme.floatingTexts[index - 1]
                            ['textAlignment'],
                        value: TextAlign.center,
                        onChanged: (value) {
                          meme.floatingTexts[index - 1]['textAlignment'] =
                              value;
                          memeTools.sinkMeme(meme, deviceWidth);
                        },
                      ),
                      Text("End"),
                      Radio<TextAlign>(
                        groupValue: meme.floatingTexts[index - 1]
                            ['textAlignment'],
                        value: TextAlign.end,
                        onChanged: (value) {
                          meme.floatingTexts[index - 1]['textAlignment'] =
                              value;
                          memeTools.sinkMeme(meme, deviceWidth);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              listTileMaterial(
                ListTile(
                  title: Text('Captions Color'),
                  leading: Icon(Icons.color_lens),
                  trailing: Container(
                    height: 20,
                    width: 30,
                    color: meme.floatingTexts[index - 1]['textStyle'].color,
                  ),
                  onTap: () async {
                    var color = await showColorPickerDialog(context,
                        meme.floatingTexts[index - 1]['textStyle'].color);
                    meme.floatingTexts[index - 1]['textStyle'] = (meme
                            .floatingTexts[index - 1]['textStyle'] as TextStyle)
                        .copyWith(color: color);
                    memeTools.sinkMeme(meme, deviceWidth);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class UiWidget extends StatelessWidget {
  const UiWidget({
    Key? key,
    required this.scrollController,
    required this.screenshotController,
    required this.canvasKey,
    required this.memeTools,
  }) : super(key: key);

  final ScrollController scrollController;
  final ScreenshotController? screenshotController;
  final GlobalKey<State<StatefulWidget>> canvasKey;
  final MemeTools? memeTools;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return StreamWidget<MemeData>(
      stream: memeTools!.stream,
      widget: (context, meme) {
        if (meme!.title.isEmpty && meme.images.isEmpty) {
          return Container(
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
          );
        } else {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top,
                bottom: 75,
              ),
              child: Screenshot(
                controller: screenshotController!,
                child: Stack(
                  children: List.generate(
                    meme.floatingTexts.length + 1,
                    (index) {
                      if (index == 0) {
                        return Container(
                          key: canvasKey,
                          width: MediaQuery.of(context).size.width,
                          color: meme.memeBackgroundColor,
                          padding: EdgeInsets.all(meme.containerPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              meme.title != ""
                                  ? Padding(
                                      padding:
                                          EdgeInsets.all(meme.titlePadding),
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
                                    padding: EdgeInsets.all(meme.imagesPadding),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          meme.borderRadius),
                                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                        onTap: () {
                                          bottomSheet(
                                            context,
                                            (context) => imageSheet(context,
                                                meme.images[index], memeTools!),
                                          );
                                        },
                                        child: memeFace(context,
                                            meme.images[index], memeTools!),
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
                          top: meme.floatingTexts[index - 1]['offset'].dy,
                          left: meme.floatingTexts[index - 1]['offset'].dx,
                          child: InkWell(
                            onTap: () {
                              bottomSheet(
                                context,
                                (context) => floatingTextSheet(
                                  context,
                                  meme,
                                  index,
                                  memeTools!,
                                ),
                              );
                            },
                            child: Draggable(
                              child: Text(
                                meme.floatingTexts[index - 1]['text'],
                                textAlign: meme.floatingTexts[index - 1]
                                    ['textAlignment'],
                                textDirection: meme.floatingTexts[index - 1]
                                    ['textDirection'],
                                style: meme.floatingTexts[index - 1]
                                    ['textStyle'],
                              ),
                              onDragEnd: (details) {
                                var obj = canvasKey.currentContext!;
                                var box = obj.findRenderObject() as RenderBox;
                                Offset of;
                                if (MediaQuery.of(context).size.height >=
                                    (box.size.height +
                                        MediaQuery.of(context)
                                            .viewPadding
                                            .top)) {
                                  of = Offset(
                                      details.offset.dx,
                                      details.offset.dy +
                                          5.5 +
                                          scrollController.offset -
                                          (MediaQuery.of(context).size.height -
                                                  (box.size.height +
                                                      MediaQuery.of(context)
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
                                meme.floatingTexts[index - 1]['offset'] = of;
                                memeTools!.sinkMeme(meme, deviceWidth);
                                debugPrint(of.toString());
                                debugPrint(MediaQuery.of(context)
                                    .viewPadding
                                    .toString());
                              },
                              feedback: Material(
                                color: Colors.transparent,
                                child: Text(
                                  meme.floatingTexts[index - 1]['text'],
                                  textAlign: meme.floatingTexts[index - 1]
                                      ['textAlignment'],
                                  textDirection: meme.floatingTexts[index - 1]
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
          );
        }
      },
    );
  }
}
