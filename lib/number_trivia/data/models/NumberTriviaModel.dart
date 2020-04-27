import 'package:flutter/cupertino.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text: text, number: number);

  // Object Factory method
  // Returns an instance of itself, hence the return type is 'Factory'
  factory NumberTriviaModel.fromJSON(Map<String, dynamic> JSON) {
    return NumberTriviaModel(
        text: JSON['text'], number: JSON['number'].toInt());
  }

  Map<String, dynamic> toJSON() {
    return {'text': text, 'number': number};
  }
}
