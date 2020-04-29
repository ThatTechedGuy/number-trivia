part of 'bloc_bloc.dart';

const CONSTANT = 1;

abstract class BlocEvent extends Equatable {
  const BlocEvent();
}

class GetTriviaFromConcreteNumber extends BlocEvent {
  final String numberString;

  GetTriviaFromConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaFromRandomNumber extends BlocEvent {
  @override
  List<Object> get props => [];
}
