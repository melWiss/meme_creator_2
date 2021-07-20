import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meme_creator_2/data.dart';
import 'package:meme_creator_2/meme_creator_2.dart';
import 'package:meme_creator_2/tools.dart';
import 'package:meme_creator_2/widgets.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' show get;
import 'package:image/image.dart' as img;

class ApiImagePicker extends StatefulWidget {
  final MemeTools memeController;
  ApiImagePicker({@required this.memeController});
  @override
  _ApiImagePickerState createState() => _ApiImagePickerState();
}

class _ApiImagePickerState extends State<ApiImagePicker>
    with SingleTickerProviderStateMixin {
  static const base = 'https://elwiss-io-meme.herokuapp.com';
  List<String> chosenUrls = [];
  List<Map> memesUrls = [];
  List<Map> searchedMemesUrls = [];
  List<Map> a9welsmaps = [];
  List<Map> searchedA9welsmaps = [];
  bool memesLoading = true;
  bool a9welsLoading = true;
  String keyword = '';
  int index = 0;
  TabController tabController;
  MemeTools memeTools;
  @override
  void initState() {
    super.initState();
    memeTools = widget.memeController;
    tabController = TabController(length: 2, vsync: this);
    get(Uri.parse(join(base, 'api', 'images'))).then((value) {
      List l = jsonDecode(value.body);
      l.forEach((element) {
        memesUrls.add({
          'path': base + element,
          'name': (element as String)
              .split('/')[(element as String).split('/').length - 1]
              .substring(
                  0,
                  (element as String)
                      .split('/')[(element as String).split('/').length - 1]
                      .indexOf('.jpeg')),
        });
      });
      setState(() {
        memesLoading = false;
      });
    }).catchError((err) {
      debugPrint(err);
    });
    get(Uri.parse(join(base, 'api', 'a9wels'))).then((value) {
      List l = jsonDecode(value.body);
      l.forEach((els) {
        (els as List).forEach((element) {
          a9welsmaps.add({
            'path': element['path'],
            'name': element['index'].toString(),
          });
        });
      });
      setState(() {
        a9welsLoading = false;
      });
    }).catchError((err) {
      debugPrint(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Image"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(5),
                //   gapPadding: 0,
                // ),
                hintText: 'Type some keywords here...',
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
              onSubmitted: (value) {
                setState(() {
                  keyword = value;
                });
              },
            ),
          ),
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black87,
            indicatorColor: Theme.of(context).primaryColor,
            controller: tabController,
            tabs: [
              Tab(
                text: 'Traditional Memes',
              ),
              Tab(
                text: 'A9wel Mdablja',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                !memesLoading
                    ? (memesUrls.where((element) {
                              if (keyword.isNotEmpty) {
                                for (var k
                                    in keyword.toUpperCase().split(' ')) {
                                  if ((element['name'] as String)
                                      .toUpperCase()
                                      .contains(k)) return true;
                                }
                                return false;
                              } else {
                                return true;
                              }
                            }).length !=
                            0
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: memesUrls.where((element) {
                              if (keyword.isNotEmpty) {
                                for (var k
                                    in keyword.toUpperCase().split(' ')) {
                                  if ((element['name'] as String)
                                      .toUpperCase()
                                      .contains(k)) return true;
                                }
                                return false;
                              } else {
                                return true;
                              }
                            }).length,
                            itemBuilder: (context, index) {
                              var memes = memesUrls.where((element) {
                                if (keyword.isNotEmpty) {
                                  for (var k
                                      in keyword.toUpperCase().split(' ')) {
                                    if ((element['name'] as String)
                                        .toUpperCase()
                                        .contains(k)) return true;
                                  }
                                  return false;
                                } else {
                                  return true;
                                }
                              }).toList();
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: NewsCard(
                                  description: memes[index]['name'],
                                  descriptionLines: 1,
                                  imgurl: memes[index]['path'],
                                  onTap: () async {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoadingScreen(),
                                    ));
                                    MemeData m = memeTools.data;
                                    int i = m.images.length;
                                    var response = await get(
                                        Uri.parse(memes[index]['path']));
                                    m.images.add({
                                      'data': response.bodyBytes,
                                      'index': i,
                                      'expanded': true,
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
                                    memeTools.imageHeightOperation(
                                        m, deviceWidth);
                                    Navigator.of(context)..pop()..pop();
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                                "There's no meme that contain those keywords."),
                          ))
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      ),
                !a9welsLoading
                    ? (a9welsmaps.where((element) {
                              if (keyword.isNotEmpty) {
                                for (var k
                                    in keyword.toUpperCase().split(' ')) {
                                  if ((element['name'] as String)
                                      .toUpperCase()
                                      .contains(k)) return true;
                                }
                                return false;
                              } else {
                                return true;
                              }
                            }).length !=
                            0
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: a9welsmaps.where((element) {
                              if (keyword.isNotEmpty) {
                                for (var k
                                    in keyword.toUpperCase().split(' ')) {
                                  if ((element['name'] as String)
                                      .toUpperCase()
                                      .contains(k)) return true;
                                }
                                return false;
                              } else {
                                return true;
                              }
                            }).length,
                            itemBuilder: (context, index) {
                              var memes = a9welsmaps.where((element) {
                                if (keyword.isNotEmpty) {
                                  for (var k
                                      in keyword.toUpperCase().split(' ')) {
                                    if ((element['name'] as String)
                                        .toUpperCase()
                                        .contains(k)) return true;
                                  }
                                  return false;
                                } else {
                                  return true;
                                }
                              }).toList();
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: NewsCard(
                                  description: memes[index]['name'],
                                  descriptionLines: 1,
                                  imgurl: memes[index]['path'],
                                  onTap: () async {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoadingScreen(),
                                    ));
                                    MemeData m = memeTools.data;
                                    int i = m.images.length;
                                    var response = await get(
                                        Uri.parse(memes[index]['path']));
                                    m.images.add({
                                      'data': response.bodyBytes,
                                      'index': i,
                                      'expanded': true,
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
                                    memeTools.imageHeightOperation(
                                        m, deviceWidth);
                                    Navigator.of(context)..pop()..pop();
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                                "There's no meme that contain those Keywords"),
                          ))
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
