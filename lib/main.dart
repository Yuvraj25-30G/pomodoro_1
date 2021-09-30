import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
    ));

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  // ignore: non_constant_identifier_names
  static int TimeInMinute = 25;
  int TimeInSecond = TimeInMinute * 60;

  // Timer timer;

  void _StartTIme() {
    TimeInMinute = 25;
    int Time = TimeInMinute * 60;
    double SecPercent = (Time / 100);
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMinute--;
          }
          if (Time % SecPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinute = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Pomodoro Clock",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 250,
                  lineWidth: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$TimeInMinute",
                    style: const TextStyle(color: Colors.white, fontSize: 80.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      "Study Time",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text(
                                      "25",
                                      style: TextStyle(fontSize: 60.0),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      "Pause Time",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text(
                                      "5",
                                      style: TextStyle(fontSize: 60.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: _StartTIme,
                                child: const Text('Start'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                  fixedSize: const Size(240, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
