import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/platform/NetworkInfo.dart';
import 'package:numbertrivia/number_trivia/data/datasources/LocalDataSource.dart';
import 'package:numbertrivia/number_trivia/data/datasources/RemoteDataSource.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/repositories/NumberTriviaRepository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    networkInfo.isConnected;
    return Right(await remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    return null;
  }
}
