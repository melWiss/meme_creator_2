import 'package:flutter/material.dart';

class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) widget;
  final Widget Function(Object error) onError;
  final Widget Function() onWait;
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
          return widget(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError == null)
            return Center(
              child: Text("Error while loading data:\n${snapshot.error}"),
            );
          else
            return onError(snapshot.error);
        } else {
          if (onWait == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return onWait();
        }
      },
    );
  }
}

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) widget;
  final Widget Function(Object error) onError;
  final Widget Function() onWait;
  const FutureWidget({this.future, this.widget, this.onError, this.onWait});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return widget(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError == null)
            return Center(
              child: Text("Error while loading data:\n${snapshot.error}"),
            );
          else
            return onError(snapshot.error);
        } else {
          if (onWait == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return onWait();
        }
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String imgurl;
  final String title;
  final String description;
  final double size;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final int descriptionLines;
  final double radius;
  final void Function() onTap;
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
                imgurl,
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
                        description,
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
