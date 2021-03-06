import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecases/usecase.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/repositories/NumberTriviaRepository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async => await repository.getConcreteNumberTrivia(params.number);
}

class Params extends Equatable{
  final int number;
  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
