import 'dart:async';


class StopWatchUtil{

  bool isStart = true;
  bool isStop = true;
  bool isReset = true;
  String stoptimetodisplay = '00:00:00:00';
  final dur = const Duration(milliseconds: 1);
  var stopwatch = Stopwatch();

  void startStopWatch() {
    isStop = false;
    isStart = false;
    stopwatch.start();
    startTimer();
  }

  void startTimer() {
    Timer(dur,keepRunning);
  }
  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }
    stoptimetodisplay = stopwatch.elapsed.inHours.toString().padLeft(2, '0') +
        ":" +
        (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
        ":" +
        (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
        ":" +
        (stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0');
  }



  void stopStopWatch() {
    isStop = true;
    isReset = false;
    stopwatch.stop();
  }

  void resetStopWatch() {
    isStop = false;
    isReset = true;
    stopwatch.reset();
  }
}

