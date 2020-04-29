import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TriviaAnimation extends StatelessWidget {
  final String animationName;

  TriviaAnimation({this.animationName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(
        'assets/animations/$animationName',
      ),
    );
  }
}
