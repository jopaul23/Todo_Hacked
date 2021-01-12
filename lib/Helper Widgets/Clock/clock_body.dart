import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Providers/time_provider.dart';
import 'clock_face.dart';

class ClockBody extends HookWidget {
  const ClockBody();

  @override
  Widget build(BuildContext context) {
    final hour = useProvider(timeHourProvider.state);
    final min = useProvider(timeMinuteProvider.state);
    final mode = useProvider(timeChangeModeProvider.state);
    final bool isHourSelected = mode == TimeChangeMode.hour;
    return Stack(
      children: [
        RichText(
            text: TextSpan(
                text: "$hour",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context
                        .read(timeChangeModeProvider)
                        .changeMode(TimeChangeMode.hour);
                  },
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHourSelected ? Colors.red : Colors.grey,
                    fontSize: 40),
                children: [
              TextSpan(
                text: ":",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
              TextSpan(
                text: "$min",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !isHourSelected ? Colors.red : Colors.grey,
                    fontSize: 40),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context
                        .read(timeChangeModeProvider)
                        .changeMode(TimeChangeMode.minute);
                  },
              ),
            ])),
        Stack(
          children: [
            Text(
              "am",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  decoration: TextDecoration.none),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "pm",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(children: <Widget>[
                Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.t1Orange,
                    ),
                    child: ClockFace(),
                  ),
                )
              ])),
        ),
      ],
    );
  }
}