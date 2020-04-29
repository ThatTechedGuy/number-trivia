import 'package:flutter/material.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/triviaAnimation.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 55,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w200
              ),
            ),
            TriviaAnimation(animationName: 'searchingAnimation.json')
          ],
        ),
      ),
    );
  }
}
