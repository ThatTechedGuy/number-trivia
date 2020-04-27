import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/number_trivia/data/models/NumberTriviaModel.dart';

abstract class NumberTriviaLocalDataSource{

  // Methods are asynchronous even though some data sources may act in sync with the code.
  // In order to prevent tangent in the intricacies of third party clashes with the application code.

  // for stability's sake, functions are still made asynchronous in nature.

  /// Gets the cached [NumberTriviaModel] which was fetched the last time the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}