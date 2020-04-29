import 'package:flutter/material.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  TriviaDisplay({@required this.numberTrivia});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              numberTrivia.number.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 80,
                  color: Theme.of(context).accentColor),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              numberTrivia.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
