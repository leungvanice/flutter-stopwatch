import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyStopWatch {
  static final Stopwatch stopwatch = Stopwatch();
  static List timeList = [];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AppContent());
  }
}

class AppContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier valueNotifier = ValueNotifier("00:00:00");
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
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
                          MyStopWatch.timeList.clear();
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
                          Duration lapTime = Duration(
                              milliseconds: stopwatch.elapsedMilliseconds);

                          setState(() {
                            MyStopWatch.timeList.add(format(lapTime));
                          });
                        }
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
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height * 0.55,
          child: ListView.builder(
            itemCount: MyStopWatch.timeList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("Lap ${index + 1}"),
                trailing: Text(MyStopWatch.timeList[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
