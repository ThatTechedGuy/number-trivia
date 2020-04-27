import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:numbertrivia/number_trivia/data/models/NumberTriviaModel.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text');

  test('should be a subclass of NumberTriviaEntity', () async {
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));
      // Act
      final result = NumberTriviaModel.fromJSON(jsonMap);
      // Assert
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the JSON number is a double',
        () async {
      // Assert
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('triviaDouble.json'));
      // Act
      final result = NumberTriviaModel.fromJSON(jsonMap);
      // Assert
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJSON', () {
    test(
        'should return a JSON map containting the proper data and model is subclass of entity',
        () async {
      // Act
      final result = tNumberTriviaModel.toJSON();
      // Assert
      final expectedMap = {"text": "Test text", "number": 1};
      expect(result, expectedMap);
    });
  });
}
