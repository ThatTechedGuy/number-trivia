part of 'bloc_bloc.dart';

abstract class BlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends BlocState {
  @override
  List<Object> get props => [];
}

class Loading extends BlocState {
  @override
  List<Object> get props => [];
}

class Loaded extends BlocState {
  final NumberTrivia numberTrivia;

  Loaded({@required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class Error extends BlocState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
