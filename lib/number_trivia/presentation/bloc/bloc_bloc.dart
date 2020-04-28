import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => Empty();

  @override
  Stream<BlocState> mapEventToState(
    BlocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
