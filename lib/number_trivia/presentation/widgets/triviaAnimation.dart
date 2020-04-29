import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TriviaAnimation extends StatelessWidget {
  final String animationName;

  TriviaAnimation({this.animationName});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/ 3,
      padding: EdgeInsets.all(1.0),
      child: Lottie.asset(
        'assets/animations/$animationName',
      ),
    );
  }
}
