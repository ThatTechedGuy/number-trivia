// Creating abstraction and contracts for simple utilities is an overkill

import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';

class InputConverter {
  /// Converts an integral string to an unsigned integer.
  ///
  /// Returns an [InvalidInputFailure] on invalid inputs or internal failures.
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      if (str.isEmpty) {
        throw FormatException();
      } else {
        final integer = int.parse(str);
        if (integer.isNegative)
          throw FormatException();
        else
          return Right(integer);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}
