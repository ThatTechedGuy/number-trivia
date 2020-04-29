import 'package:flutter/material.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/triviaAnimation.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool isError;

  const MessageDisplay({@required this.message, @required this.isError});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: isError ? Colors.red : Theme.of(context).accentColor,
                    fontWeight: isError ? FontWeight.w700 : FontWeight.w200),
              ),
            ),
            TriviaAnimation(animationName: 'searchingAnimation.json')
          ],
        ),
      ),
    );
  }
}
