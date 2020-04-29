import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/core/network/NetworkInfo.dart';
import 'package:numbertrivia/number_trivia/data/datasources/LocalDataSource.dart';
import 'package:numbertrivia/number_trivia/data/datasources/RemoteDataSource.dart';
import 'package:numbertrivia/number_trivia/data/repositories/NumberTriviaRepositoryImpl.dart';
import 'package:numbertrivia/number_trivia/domain/repositories/NumberTriviaRepository.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetConcreteNumberTrivia.dart';
import 'package:numbertrivia/number_trivia/domain/use_cases/GetRandomNumberTrivia.dart';
import 'package:numbertrivia/number_trivia/presentation/bloc/bloc_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/utils/InputConverter.dart';

final sl = GetIt.instance;

Future<void> init() async{
  //! Features - Number Trivia
  // Bloc - not registered as a Singleton in order to enforce state cleanup.
  sl.registerFactory(
    () => BloC(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  // Lazy singletons only registered when called. Cached and registered only once.

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

}
