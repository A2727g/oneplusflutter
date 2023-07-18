import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tickets/utils/constants.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.onClick}) : super(key: key);
  final Function(bool) onClick;

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  int _time = 30;
  late Timer _timerUI;

  @override
  void initState() {
    super.initState();
    startCountDownFunc();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logPrint.w('rebuilding timer widget');
    var textTheme = Theme.of(context).textTheme;
    return _time > 0
        ? Row(
            children: [
              Text("resend OTP in ",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              Text("$_time s",
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent))
            ],
          )
        : InkWell(
            onTap: () async {
              widget.onClick(true);
              setState(() {
                _time = 30;
              });
              cancelTimer();
              startCountDownFunc();
            },
            child: Text("resend",
                style: textTheme.bodyText2!
                    .copyWith(color: Colors.redAccent, fontSize: 16)),
          );
  }

  startCountDownFunc() {
    _timerUI = Timer.periodic(const Duration(seconds: 1), decTimer);
  }

  cancelTimer() {
    if (_timerUI.isActive) {
      _timerUI.cancel();
    }
  }

  decTimer(Timer timer) {
    if (_time > 0) {
      setState(() {
        _time -= 1;
      });
    } else {
      cancelTimer();
      return;
    }
  }
}
