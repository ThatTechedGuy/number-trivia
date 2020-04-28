import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/utils/InputConverter.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetConcreteNumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetRandomNumberTrivia.dart';
import 'package:numbertrivia/number_trivia/presentation/bloc/bloc_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  BloC bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = BloC(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state should be Empty', () {
    // Assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = "1";
    final tNumberParsed = 1;

    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test('should call the InputConverter to validate and convert input',
        () async {
      // Arrange
      setUpMockInputConverterSuccess();
      // Act
      bloc.add(GetTriviaFromConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      // Assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaFromConcreteNumber(tNumberString));
      },
    );

    test('should get data from the use case on a valid input', () async {
      // arrange
      setUpMockInputConverterSuccess();

      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // Act
      bloc.add(GetTriviaFromConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      // Assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] state when data fetch is successful',
        () async {
      // arrange
      setUpMockInputConverterSuccess();

      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(numberTrivia: tNumberTrivia)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] state when data fetch is unsuccessful',
        () async {
      // arrange
      setUpMockInputConverterSuccess();

      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromConcreteNumber(tNumberString));
    });

    test('on known error, print a proper message on data fetch', () async {
      // arrange
      setUpMockInputConverterSuccess();

      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    test('should emit [Loading, Loaded] state when data fetch is successful',
        () async {
      // arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(numberTrivia: tNumberTrivia)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromRandomNumber());
    });

    test('should emit [Loading, Error] state when data fetch is unsuccessful',
        () async {
      // arrange

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromRandomNumber());
    });

    test('on known error, print a proper message on data fetch', () async {
      // arrange

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaFromRandomNumber());
    });
  });
}
