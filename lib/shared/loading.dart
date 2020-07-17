///File description: Loading widget while data is processing.
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color2,
        child: Center(
            child: SpinKitChasingDots(
                color: color1,
                size: 50.0
            )
        )
    );
  }
}
