import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/platform/network_information.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_tdd_clean_architecture/modules/number_trivia/domain/repositories/number_trivia_repository_contract.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepository implements NumberTriviaRepositoryContract {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInformation networkInformation;

  NumberTriviaRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInformation,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
    int number,
  ) =>
      _getNumberTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() =>
      _getNumberTrivia(remoteDataSource.getRandomNumberTrivia);

  Future<Either<Failure, NumberTriviaEntity>> _getNumberTrivia(
    _ConcreteOrRandomChooser function,
  ) async {
    if (await networkInformation.isConnected) {
      try {
        final NumberTriviaModel remoteTrivia = await function();

        localDataSource.cacheNumberTrivia(remoteTrivia);

        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final NumberTriviaModel localTrivia =
            await localDataSource.getLastNumberTrivia();

        return (Right(localTrivia));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
