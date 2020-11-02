import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopWatchUtil extends StatefulWidget {
  @override
  _StopWatchUtilState createState() => _StopWatchUtilState();
}

class _StopWatchUtilState extends State<StopWatchUtil> {
  bool isStart = true;
  bool isStop = true;
  bool isReset = true;
  String stoptimetodisplay = '00:00:00:00';
  final dur = const Duration(milliseconds: 1);
  var stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(stoptimetodisplay),
          RaisedButton(
            onPressed: startStopWatch,
            child: Text('Start'),
          ),
          RaisedButton(
            onPressed: stopStopWatch,
            child: Text('Stop'),
          )
        ],
      ),
    );
  }

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }
    setState(() {
      stoptimetodisplay = stopwatch.elapsed.inHours.toString().padLeft(2, '0') +
          ":" +
          (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ":" +
          (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
          ":" +
          (stopwatch.elapsed.inMilliseconds %100).toString().padLeft(2, '0');
    });
  }

  void startStopWatch() {
    setState(() {
      isStop = false;
      isStart = false;
    });
    stopwatch.start();
    startTimer();
  }

  void stopStopWatch() {
    setState(() {
      isStop = true;
      isReset = false;
    });
    stopwatch.stop();
  }
  void resetStopWatch(){
    setState(() {
      isStop = false;
      isReset = true;
    });
    stopwatch.reset();
  }
}
