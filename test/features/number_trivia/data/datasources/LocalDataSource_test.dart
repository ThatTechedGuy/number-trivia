import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/exceptions.dart';
import 'package:numbertrivia/number_trivia/data/datasources/LocalDataSource.dart';
import 'package:numbertrivia/number_trivia/data/models/NumberTriviaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJSON(jsonDecode(fixture('triviaCached.json')));
    test(
        'should return NumberTriviaModel from SharedPreferences when there is one in the cache',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('triviaCached.json'));
      // Act
      final result = await dataSource.getLastNumberTrivia();
      // Assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
    });

    test(
        'should return CacheException when there is nothing in the local Storage',
        () async {
      // Arrange -> arrangement to return an undefined value
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // Act
      // holds the function itself
      final call = dataSource.getLastNumberTrivia;
      // Assert
      // A CacheException is expected to be thrown on call.
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    test('should call SharedPrefernces to cache the data', () async {
      final tNumberTriviaModel =
          NumberTriviaModel(number: 1, text: 'Test trivia');
      // Arrange
      // No arrangements as we cannot control the SharedPreferences from a unit test.

      // Act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      // Assert
      final expectedJSONString = jsonEncode(tNumberTriviaModel.toJSON());
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJSONString));
    });
  });
}
