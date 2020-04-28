import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/number_trivia/data/models/NumberTriviaModel.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number}?json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random?json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final response = await client.get(
      'http://numbersapi.com/$number',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJSON(jsonDecode(response.body));
    else
      throw ServerException();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final response = await client.get(
      'http://numbersapi.com/random',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJSON(jsonDecode(response.body));
    else
      throw ServerException();
  }
}
