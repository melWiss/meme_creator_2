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
