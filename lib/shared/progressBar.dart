import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:blmhackathon/shared/constants.dart';

class ProgressBar extends StatefulWidget {
  final double percent;
  ProgressBar({this.percent});
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
      width: 300.0,
      lineHeight: 14.0,
      percent: widget.percent,
      backgroundColor: color4,
      progressColor: color2,
    );
  }
}

