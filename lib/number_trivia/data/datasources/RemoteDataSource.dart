import 'package:numbertrivia/number_trivia/data/models/NumberTriviaModel.dart';

abstract class NumberTriviaRemoveDataSource{
  /// Calls the http://numbersapi.com/{number}?json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia();
  /// Calls the http://numbersapi.com/random?json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();

}