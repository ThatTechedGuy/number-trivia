import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/utils/InputConverter.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetConcreteNumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetRandomNumberTrivia.dart';

part 'bloc_event.dart';

part 'bloc_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive or zero.';
const String UNKNOWN_FAILURE_MESSAGE = 'Something went wrong';

class BloC extends Bloc<BlocEvent, BlocState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  // @NonNull
  BloC({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  BlocState get initialState => Empty();

  @override
  Stream<BlocState> mapEventToState(
    BlocEvent event,
  ) async* {
    if (event is GetTriviaFromConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        // Although the "success case" doesn't interest us with the current test,
        // we still have to handle it somehow.
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield failureOrTrivia.fold(
            (failure) => Error(message: appropriateErrorMessage(failure)),
            (trivia) => Loaded(numberTrivia: trivia),
          );
        },
      );
    }
  }

  String appropriateErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      default: // Unknown failures
        return UNKNOWN_FAILURE_MESSAGE;
    }
  }
}
