import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecases/usecase.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/repositories/NumberTriviaRepository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async =>
      await repository.getRandomNumberTrivia();
}
