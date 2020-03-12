import 'dart:async';

import 'package:flutter/material.dart';
import 'timer_page.dart';

void main() => runApp(MyApp());

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

class StopwatchApp extends StatelessWidget {
  ValueNotifier valueNotifier;
  StopwatchApp(this.valueNotifier);
  Stopwatch stopwatch = Stopwatch();
  format(Duration d) {
    return d.toString().split('.').first.padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            child: Text("Start"),
            onPressed: () {
              if (stopwatch.isRunning) {
                print("Started already");
              } else {
                stopwatch.start();
                print("Started");
              }
              Timer.periodic(Duration(seconds: 1), (callback) {
                valueNotifier.value = format(
                    Duration(milliseconds: stopwatch.elapsedMilliseconds));
              });
            },
          ),
          SizedBox(
            width: 100,
          ),
          FloatingActionButton(
            child: Text("Stop"),
            onPressed: () {
              if (stopwatch.isRunning) {
                stopwatch.stop();
                stopwatch.reset();
                valueNotifier.value = '00:00:00';
              }
            },
          ),
        ],
      ),
    );
  }
}
