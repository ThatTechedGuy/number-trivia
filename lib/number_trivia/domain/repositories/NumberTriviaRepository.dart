import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}