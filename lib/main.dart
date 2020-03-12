import 'dart:async';

import 'package:flutter/material.dart';
import 'timer_page.dart';

void main() => runApp(MyApp());

class MyStopWatch {
  static final Stopwatch stopwatch = Stopwatch();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier valueNotifier = ValueNotifier("00:00:00");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stopwatch"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(50),
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (context, value, child) {
                  return Text(
                    value,
                    style: TextStyle(
                      fontSize: 38,
                    ),
                  );
                },
              ),
            ),
            StopwatchApp(valueNotifier),
          ],
        ),
      ),
    );
  }
}

class StopwatchApp extends StatefulWidget {
  ValueNotifier valueNotifier;
  StopwatchApp(this.valueNotifier);

  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  Stopwatch stopwatch = MyStopWatch.stopwatch;

  format(Duration d) {
    return d.toString().split('.').first.padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !stopwatch.isRunning
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Reset btn
                FloatingActionButton(
                  child: Text("Reset"),
                  onPressed: () {
                    stopwatch.reset();
                    widget.valueNotifier.value = '00:00:00';

                    setState(() {
                      widget.valueNotifier.value = '00:00:00';
                    });
                  },
                ),
                SizedBox(
                  width: 100,
                ),
                // Start btn
                FloatingActionButton(
                  child: Text('Start'),
                  onPressed: () {
                    if (stopwatch.isRunning) {
                      print("Started already");
                    } else {
                      stopwatch.start();
                      print("Started");
                    }
                    setState(() {});
                    Timer.periodic(Duration(seconds: 1), (callback) {
                      widget.valueNotifier.value = format(Duration(
                          milliseconds: stopwatch.elapsedMilliseconds));
                    });
                  },
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // lap btn
                FloatingActionButton(
                  child: Text("lap"),
                  onPressed: () {
                    if (stopwatch.isRunning) {
                      print(format(Duration(
                          milliseconds: stopwatch.elapsedMilliseconds)));
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 100,
                ),
                // Start btn
                FloatingActionButton(
                  child: Text("stop"),
                  onPressed: () {
                    if (stopwatch.isRunning) {
                      stopwatch.stop();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
    );
  }
}
