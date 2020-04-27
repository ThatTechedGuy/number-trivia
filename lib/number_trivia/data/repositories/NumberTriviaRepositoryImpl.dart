import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/repositories/NumberTriviaRepository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {


  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {


  }

}